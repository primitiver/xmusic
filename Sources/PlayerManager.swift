import AVFoundation
import Foundation
import Combine
import MediaPlayer

class PlayerManager: ObservableObject {
    private var player: AVPlayer?
    private var timeObserver: Any?
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isPlaying = false
    @Published var currentTrack: MusicTrack?
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var bufferedTime: Double = 0
    @Published var lyrics: String = "" {
        didSet {
            parsedLyrics = parseLyrics(lyrics)
        }
    }
    @Published var parsedLyrics: [LyricLine] = []
    @Published var currentPlaylist: [MusicTrack] = []
    @Published var currentIndex: Int = 0
    @Published var playMode: PlayMode = .loopAll {
        didSet {
            UserDefaults.standard.set(playMode.rawValue, forKey: "playMode")
            updateRemoteCommandCenter()
        }
    }

    enum PlayMode: String, CaseIterable {
        case sequential    // 顺序播放
        case loopAll      // 列表循环
        case loopOne      // 单曲循环
        case shuffle      // 随机播放
    }

    private var shuffledIndices: [Int] = []
    
    struct LyricLine: Identifiable {
        let id = UUID()
        let time: Double
        let text: String
    }
    
    struct MusicTrack: Identifiable, Codable {
        let id: String
        let name: String
        let singer: String
        let albumName: String?
        let imageUrl: String?
        let audioUrl: String
        var lrcUrl: String?
        var lrc: String?
        var sourceUrl: String?
    }
    
    init() {
        setupAudioSession()
        setupRemoteCommandCenter()
        loadLastPlayedTrack()
        loadPlayMode()
    }

    private func loadPlayMode() {
        if let rawValue = UserDefaults.standard.string(forKey: "playMode"),
           let mode = PlayMode(rawValue: rawValue) {
            playMode = mode
        }
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            print("🔊 [Player] Audio Session configured")
        } catch {
            print("❌ [Player] Audio Session Error: \(error.localizedDescription)")
        }
    }
    
    private func saveLastPlayedTrack() {
        if let track = currentTrack, let encoded = try? JSONEncoder().encode(track) {
            UserDefaults.standard.set(encoded, forKey: "lastPlayedTrack")
        }
        
        if !currentPlaylist.isEmpty, let encodedPlaylist = try? JSONEncoder().encode(currentPlaylist) {
            UserDefaults.standard.set(encodedPlaylist, forKey: "lastPlayedPlaylist")
            UserDefaults.standard.set(currentIndex, forKey: "lastPlayedIndex")
        }
    }
    
    private func loadLastPlayedTrack() {
        if let savedTrack = UserDefaults.standard.data(forKey: "lastPlayedTrack"),
           let loadedTrack = try? JSONDecoder().decode(MusicTrack.self, from: savedTrack) {
            self.currentTrack = loadedTrack
            // Also load lyrics if available
            if let lrc = loadedTrack.lrc {
                self.lyrics = lrc
            }
            print("💾 [Player] Loaded last played track: \(loadedTrack.name)")
        }
        
        if let savedPlaylist = UserDefaults.standard.data(forKey: "lastPlayedPlaylist"),
           let loadedPlaylist = try? JSONDecoder().decode([MusicTrack].self, from: savedPlaylist) {
            self.currentPlaylist = loadedPlaylist
            self.currentIndex = UserDefaults.standard.integer(forKey: "lastPlayedIndex")
            print("💾 [Player] Loaded playlist with \(loadedPlaylist.count) tracks")
        }
    }
    
    func play(track: MusicTrack) {
        // Reset state for new track
        self.currentTime = 0
        self.duration = 0
        self.bufferedTime = 0
        
        let playUrl: URL
        let isLocal: Bool
        
        // 1. Check local cache
        if let cachedUrl = MusicCacheManager.shared.cachedURL(for: track.id) {
            print("💾 [Player] Hit cache: \(track.name)")
            playUrl = cachedUrl
            isLocal = true
        } else {
            // 2. Use remote URL
            guard let url = URL(string: track.audioUrl) else { 
                print("❌ [Player] Invalid audio URL: \(track.audioUrl)")
                return 
            }
            playUrl = url
            isLocal = false
            print("🎵 [Player] Resolved Audio URL: \(track.audioUrl)")
            
            // 3. Start caching in background if not local
            MusicCacheManager.shared.startCaching(url: track.audioUrl, id: track.id)
        }
        
        if let timeObserver = timeObserver {
            player?.removeTimeObserver(timeObserver)
        }

        let headers: [String: String] = [
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
            "Referer": "https://www.jbsou.cn/"
        ]
        
        // For local files, we don't need custom headers typically, but AVURLAsset handles file URLs fine.
        let assetOptions = isLocal ? nil : ["AVURLAssetHTTPHeaderFieldsKey": headers]
        let asset = AVURLAsset(url: playUrl, options: assetOptions)
        
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        currentTrack = track
        
        if let trackLrc = track.lrc {
            self.lyrics = trackLrc
        }
        
        print("🎵 [Player] Ready to play: \(track.name) (Local: \(isLocal))")
        
        // Monitor item status
        playerItem.publisher(for: \.status)
            .sink { [weak self] status in
                switch status {
                case .failed:
                    print("❌ [Player] Item failed: \(String(describing: self?.player?.currentItem?.error?.localizedDescription))")
                case .readyToPlay:
                    print("✅ [Player] Ready to play")
                case .unknown:
                    print("⚠️ [Player] Unknown item status")
                @unknown default:
                    break
                }
            }
            .store(in: &cancellables)
        
        // Monitor player errors
        player?.publisher(for: \.error)
            .sink { error in
                if let error = error {
                    print("❌ [Player] Player error: \(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)
        
        playerItem.publisher(for: \.loadedTimeRanges)
            .sink { [weak self] ranges in
                if let firstRange = ranges.first?.timeRangeValue {
                    let startSeconds = CMTimeGetSeconds(firstRange.start)
                    let durationSeconds = CMTimeGetSeconds(firstRange.duration)
                    self?.bufferedTime = startSeconds + durationSeconds
                }
            }
            .store(in: &cancellables)
        
        // Listen for playback completion
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: playerItem)
            .sink { [weak self] _ in
                print("🏁 [Player] Track finished playing")
                self?.handleTrackFinished()
            }
            .store(in: &cancellables)
        
        playerItem.publisher(for: \.duration)
            .sink { [weak self] duration in
                let secs = duration.seconds.isNaN ? 0 : duration.seconds
                print("⏳ [Player] Duration updated: \(secs)s")
                self?.duration = secs
                self?.updateNowPlayingInfo()
            }
            .store(in: &cancellables)
        
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
            self?.updateNowPlayingPlaybackValues()
        }
        
        player?.play()
        isPlaying = true
        updateNowPlayingInfo()
        saveLastPlayedTrack()
        print("🎵 [Player] Started playing: \(track.name)")
    }
    
    func togglePlayPause() {
        if player == nil, let track = currentTrack {
            // Player not initialized (e.g., after app restart)
            // Try to resolve URL and play
            print("🔄 [Player] Restoring playback for: \(track.name)")

            // Detect Kugou song by track ID (32-char hex hash)
            let isKugou = track.id.count == 32 && track.id.range(of: "^[0-9a-fA-F]+$", options: .regularExpression) != nil

            if isKugou {
                // Kugou song - re-resolve via search API
                MusicApiService.shared.resolveKugouPlayUrl(name: track.name, artist: track.singer, hash: track.id) { [weak self] resolvedUrl, _ in
                    guard let self = self, let url = resolvedUrl else { return }

                    DispatchQueue.main.async {
                        let freshTrack = MusicTrack(
                            id: track.id,
                            name: track.name,
                            singer: track.singer,
                            albumName: track.albumName,
                            imageUrl: track.imageUrl,
                            audioUrl: url,
                            lrcUrl: track.lrcUrl,
                            lrc: track.lrc,
                            sourceUrl: track.sourceUrl ?? track.audioUrl
                        )
                        self.play(track: freshTrack)
                    }
                }
            } else {
                // jbsou.cn song - resolve normally
                let urlToResolve = track.sourceUrl ?? track.audioUrl
                MusicApiService.shared.resolvePlayUrl(url: urlToResolve) { [weak self] resolvedUrl in
                    guard let self = self, let url = resolvedUrl else { return }

                    DispatchQueue.main.async {
                        let freshTrack = MusicTrack(
                            id: track.id,
                            name: track.name,
                            singer: track.singer,
                            albumName: track.albumName,
                            imageUrl: track.imageUrl,
                            audioUrl: url,
                            lrcUrl: track.lrcUrl,
                            lrc: track.lrc,
                            sourceUrl: track.sourceUrl ?? track.audioUrl
                        )
                        self.play(track: freshTrack)
                    }
                }
            }
            return
        }

        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
        updateNowPlayingPlaybackValues()
    }
    
    func seek(to time: Double) {
        let targetTime = CMTime(seconds: time, preferredTimescale: 1)
        player?.seek(to: targetTime)
        updateNowPlayingPlaybackValues()
    }
    
    // MARK: - Media Player Support
    
    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.playCommand.addTarget { [weak self] _ in
            self?.togglePlayPause()
            return .success
        }

        commandCenter.pauseCommand.addTarget { [weak self] _ in
            self?.togglePlayPause()
            return .success
        }

        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
            if let positionEvent = event as? MPChangePlaybackPositionCommandEvent {
                self?.seek(to: positionEvent.positionTime)
                return .success
            }
            return .commandFailed
        }

        commandCenter.nextTrackCommand.addTarget { [weak self] _ in
            self?.playNext()
            return .success
        }

        commandCenter.previousTrackCommand.addTarget { [weak self] _ in
            self?.playPrevious()
            return .success
        }
    }

    private func updateRemoteCommandCenter() {
        // Update remote command center for play mode changes
        MPRemoteCommandCenter.shared().nextTrackCommand.isEnabled = canPlayNext()
        MPRemoteCommandCenter.shared().previousTrackCommand.isEnabled = canPlayPrevious()
    }
    
    private func updateNowPlayingInfo() {
        guard let track = currentTrack else { return }
        
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = track.name
        nowPlayingInfo[MPMediaItemPropertyArtist] = track.singer
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = track.albumName ?? ""
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player?.rate ?? 0.0
        
        // Artwork from URL can be added here using a downloader
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func updateNowPlayingPlaybackValues() {
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player?.rate ?? 0.0
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func parseLyrics(_ lrc: String) -> [LyricLine] {
        var lines: [LyricLine] = []
        let pattern = "\\[(\\d+):(\\d+\\.?\\d*)\\](.*)"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        let nsString = lrc as NSString
        let results = regex?.matches(in: lrc, range: NSRange(location: 0, length: nsString.length)) ?? []
        
        for result in results {
            if result.numberOfRanges >= 4 {
                let min = Double(nsString.substring(with: result.range(at: 1))) ?? 0
                let sec = Double(nsString.substring(with: result.range(at: 2))) ?? 0
                let text = nsString.substring(with: result.range(at: 3)).trimmingCharacters(in: .whitespaces)
                
                let time = min * 60 + sec
                lines.append(LyricLine(time: time, text: text))
            }
        }
        
        return lines.sorted { $0.time < $1.time }
    }
    
    // MARK: - Playlist Management (Recent-track based)

    /// Sync the current playlist from the recent track entities.
    /// Call this from HomeView before playNext/Previous to ensure consistency.
    /// Toggle through play modes: sequential -> loopAll -> loopOne -> shuffle -> sequential
    func togglePlayMode() {
        if let index = PlayMode.allCases.firstIndex(of: playMode) {
            let nextIndex = (index + 1) % PlayMode.allCases.count
            playMode = PlayMode.allCases[nextIndex]
        }
    }

    func setPlaylistFromRecent(_ entities: [RecentTrackEntity]) {
        currentPlaylist = entities.map { entity in
            MusicTrack(
                id: entity.id,
                name: entity.name,
                singer: entity.singer,
                albumName: entity.albumName,
                imageUrl: entity.imageUrl,
                audioUrl: entity.audioUrl,
                lrcUrl: entity.lrcUrl,
                lrc: entity.lrc,
                sourceUrl: entity.audioUrl
            )
        }
        if let track = currentTrack,
           let idx = currentPlaylist.firstIndex(where: { $0.id == track.id }) {
            currentIndex = idx
        } else {
            currentIndex = 0
        }
        generateShuffledIndices()
    }

    func setPlaylist(tracks: [MusicTrack], startIndex: Int = 0) {
        currentPlaylist = tracks
        currentIndex = startIndex
        generateShuffledIndices()
        if startIndex < tracks.count {
            play(track: tracks[startIndex])
        }
    }

    private func generateShuffledIndices() {
        let count = currentPlaylist.count
        shuffledIndices = Array(0..<count).shuffled()
    }

    func playNext() {
        guard !currentPlaylist.isEmpty else { return }
        switch playMode {
        case .sequential, .loopOne:
            if currentIndex < currentPlaylist.count - 1 {
                currentIndex += 1
                resolveAndPlay(track: currentPlaylist[currentIndex])
            }
        case .loopAll:
            currentIndex = (currentIndex + 1) % currentPlaylist.count
            resolveAndPlay(track: currentPlaylist[currentIndex])
        case .shuffle:
            playNextInShuffle()
        }
    }

    func playPrevious() {
        guard !currentPlaylist.isEmpty else { return }
        switch playMode {
        case .sequential, .loopAll, .loopOne:
            currentIndex = currentIndex > 0 ? currentIndex - 1 : currentPlaylist.count - 1
            resolveAndPlay(track: currentPlaylist[currentIndex])
        case .shuffle:
            playPreviousInShuffle()
        }
    }

    private func playNextInShuffle() {
        guard let currentIndex = shuffledIndices.firstIndex(of: currentIndex) else {
            // Current index not in shuffle list, regenerate
            generateShuffledIndices()
            return playNextInShuffle()
        }
        let nextShuffleIndex = (currentIndex + 1) % shuffledIndices.count
        let trackIndex = shuffledIndices[nextShuffleIndex]
        self.currentIndex = trackIndex
        resolveAndPlay(track: currentPlaylist[trackIndex])
    }

    private func playPreviousInShuffle() {
        guard let currentIndex = shuffledIndices.firstIndex(of: currentIndex) else {
            generateShuffledIndices()
            return playPreviousInShuffle()
        }
        let prevShuffleIndex = currentIndex > 0 ? currentIndex - 1 : shuffledIndices.count - 1
        let trackIndex = shuffledIndices[prevShuffleIndex]
        self.currentIndex = trackIndex
        resolveAndPlay(track: currentPlaylist[trackIndex])
    }
    
    // Helper to resolve URL before playing
    private func resolveAndPlay(track: MusicTrack) {
        // 1. Check if already cached locally
        if MusicCacheManager.shared.isCached(id: track.id), let cachedUrl = MusicCacheManager.shared.cachedURL(for: track.id) {
             print("💾 [Player] Auto-play hit cache: \(track.name)")
             // Create a track instance pointing to local file
             // We can skip resolution because we have the file
             DispatchQueue.main.async {
                 let localTrack = MusicTrack(
                     id: track.id,
                     name: track.name,
                     singer: track.singer,
                     albumName: track.albumName,
                     imageUrl: track.imageUrl,
                     audioUrl: cachedUrl.absoluteString,
                     lrcUrl: track.lrcUrl,
                     lrc: track.lrc,
                     sourceUrl: track.sourceUrl
                 )
                 self.play(track: localTrack)
             }
             return
        }
        
        // 2. Not cached, resolve remote URL
        // Detect Kugou song by track ID (32-char hex hash)
        let isKugou = track.id.count == 32 && track.id.range(of: "^[0-9a-fA-F]+$", options: .regularExpression) != nil

        if isKugou {
            MusicApiService.shared.resolveKugouPlayUrl(name: track.name, artist: track.singer, hash: track.id) { [weak self] resolvedUrl, lrcUrl in
                guard let self = self, let url = resolvedUrl else { return }

                DispatchQueue.main.async {
                    let updatedTrack = MusicTrack(
                        id: track.id,
                        name: track.name,
                        singer: track.singer,
                        albumName: track.albumName,
                        imageUrl: track.imageUrl,
                        audioUrl: url,
                        lrcUrl: lrcUrl?.isEmpty == false ? lrcUrl! : track.lrcUrl,
                        lrc: track.lrc,
                        sourceUrl: track.sourceUrl
                    )

                    self.play(track: updatedTrack)

                    if updatedTrack.lrc == nil, let lrcUrl = updatedTrack.lrcUrl {
                        MusicApiService.shared.fetchLyric(lrcUrl: lrcUrl) { lrc in
                            if let lyric = lrc {
                                DispatchQueue.main.async {
                                    self.lyrics = lyric
                                }
                            }
                        }
                    }
                }
            }
            return
        }

        let urlToResolve = track.sourceUrl ?? track.audioUrl
        MusicApiService.shared.resolvePlayUrl(url: urlToResolve) { [weak self] resolvedUrl in
            guard let self = self, let url = resolvedUrl else { return }
            
            DispatchQueue.main.async {
                // Create a new track with the resolved audio URL
                let updatedTrack = MusicTrack(
                    id: track.id,
                    name: track.name,
                    singer: track.singer,
                    albumName: track.albumName,
                    imageUrl: track.imageUrl,
                    audioUrl: url,
                    lrcUrl: track.lrcUrl,
                    lrc: track.lrc,
                    sourceUrl: track.sourceUrl ?? track.audioUrl
                )
                
                self.play(track: updatedTrack)
                
                 // If we have missing lyric content but have a URL, fetch it now too
                if updatedTrack.lrc == nil, let lrcUrl = updatedTrack.lrcUrl {
                    MusicApiService.shared.fetchLyric(lrcUrl: lrcUrl) { lrc in
                        if let lyric = lrc {
                            DispatchQueue.main.async {
                                self.lyrics = lyric
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func handleTrackFinished() {
        guard !currentPlaylist.isEmpty else { return }

        switch playMode {
        case .sequential:
            if currentIndex < currentPlaylist.count - 1 {
                playNext()
            }
        case .loopAll:
            playNext()
        case .loopOne:
            resolveAndPlay(track: currentPlaylist[currentIndex])
        case .shuffle:
            playNextInShuffle()
        }
    }

    func canPlayNext() -> Bool {
        !currentPlaylist.isEmpty && (playMode == .loopAll || playMode == .loopOne || playMode == .shuffle || currentIndex < currentPlaylist.count - 1)
    }

    func canPlayPrevious() -> Bool {
        !currentPlaylist.isEmpty
    }
}
