import SwiftUI
import SwiftData

struct PlayerView: View {
    @EnvironmentObject var playerManager: PlayerManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query var favorites: [MusicTrackEntity]
    @Query(sort: \RecentTrackEntity.lastPlayed, order: .reverse) var recentTracks: [RecentTrackEntity]
    @State private var showingLyrics = false
    @State private var localTime: Double = 0
    @State private var isDraggingSlider = false
    @State private var showingRecentList = false
    
    var body: some View {
        ZStack {
            // Background Blur - Constrained to screen size
            if let track = playerManager.currentTrack {
                GeometryReader { geo in
                    AsyncImage(url: URL(string: (track.imageUrl ?? "").normalizedMusicUrl)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .blur(radius: 50)
                            .opacity(0.5)
                    } placeholder: {
                        Color.black
                    }
                }
                .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.down")
                            .font(.title2.bold())
                    }
                    .frame(width: 44, height: 44)
                    
                    Spacer()
                    
                    Text("正在播放")
                        .font(.headline)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundColor(.white)
                .padding(.top, 10)
                
                Spacer()
                
                // Paging View for Album Art and Lyrics
                TabView(selection: $showingLyrics) {
                    // Page 0: Album Art
                    VStack {
                        if let track = playerManager.currentTrack {
                            GeometryReader { geo in
                                AsyncImage(url: URL(string: (track.imageUrl ?? "").normalizedMusicUrl)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(20)
                                        .shadow(radius: 20)
                                } placeholder: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.gray.opacity(0.3))
                                        .overlay(Image(systemName: "music.note").font(.system(size: 80)))
                                }
                                .frame(width: geo.size.width * 0.8)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .padding(20)
                        }
                    }
                    .tag(false)
                    
                    // Page 1: Lyrics
                    VStack {
                        ScrollViewReader { proxy in
                            ScrollView(showsIndicators: false) {
                                VStack(spacing: 25) {
                                    if playerManager.parsedLyrics.isEmpty {
                                        Text(playerManager.lyrics.isEmpty ? "暂无歌词" : playerManager.lyrics)
                                            .font(.title2)
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                    } else {
                                        ForEach(playerManager.parsedLyrics) { line in
                                            let isActive = isCurrentLine(line)
                                            Text(line.text)
                                                .font(isActive ? .title2.bold() : .title3)
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(isActive ? .white : .white.opacity(0.4))
                                                .scaleEffect(isActive ? 1.05 : 1.0)
                                                .animation(.spring(), value: isActive)
                                                .id(line.id)
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                                .padding(.vertical, 100)
                            }
                            .onChange(of: playerManager.currentTime) { newValue in
                                if let currentLineID = activeLineID() {
                                    withAnimation {
                                        proxy.scrollTo(currentLineID, anchor: .center)
                                    }
                                }
                            }
                        }
                    }
                    .tag(true)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(maxHeight: .infinity)
                
                Spacer()
                
                // Track Info & Controls - Bottom Section
                VStack(spacing: 30) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(playerManager.currentTrack?.name ?? "未知歌曲")
                                .font(.title2.bold())
                                .lineLimit(1)
                            Text(playerManager.currentTrack?.singer ?? "未知歌手")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.8))
                                .lineLimit(1)
                        }
                        Spacer()

                        if let track = playerManager.currentTrack {
                            Button(action: {
                                toggleFavorite(track)
                            }) {
                                Image(systemName: isFavorite(track.id) ? "heart.fill" : "heart")
                                    .font(.title2)
                                    .foregroundColor(isFavorite(track.id) ? .red : .white)
                            }

                            // Recent Playlist Button
                            Button(action: { showingRecentList = true }) {
                                Image(systemName: "list.bullet")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    // Progress Bar
                    VStack(spacing: 8) {
                        ZStack(alignment: .leading) {
                            // Buffer Track
                            GeometryReader { geo in
                                Capsule()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: geo.size.width * CGFloat(playerManager.bufferedTime / max(playerManager.duration, 1)))
                            }
                            .frame(height: 3) // Match slider track height approximately
                            
                            Slider(value: $localTime, in: 0...max(playerManager.duration, 1), onEditingChanged: { dragging in
                                if dragging {
                                    isDraggingSlider = true
                                } else {
                                    playerManager.seek(to: localTime)
                                }
                            })
                            .accentColor(.white)
                        }
                        
                        HStack {
                            Text(formatTime(isDraggingSlider ? localTime : playerManager.currentTime))
                            Spacer()
                            Text(formatTime(playerManager.duration))
                        }
                    }
                    .padding(.horizontal, 30)
                    .onChange(of: playerManager.currentTime) { newValue in
                        if isDraggingSlider {
                            // 如果播放器的新时间已经接近我们设置的时间，就认为 seek 完成
                            if abs(localTime - newValue) < 0.5 {
                                isDraggingSlider = false
                            }
                        } else {
                            localTime = newValue
                        }
                    }
                    
                    // Main Controls
                    HStack(spacing: 25) {
                        // Play Mode Button - Left side
                        Button(action: {
                            playerManager.togglePlayMode()
                            HapticManager.shared.selection()
                        }) {
                            Image(systemName: playModeIcon)
                                .font(.body)
                                .foregroundColor(.white.opacity(0.7))
                                .frame(width: 44, height: 44)
                        }

                        Button(action: {
                            playerManager.playPrevious()
                            HapticManager.shared.selection()
                        }) {
                            Image(systemName: "backward.fill")
                                .font(.title)
                                .foregroundColor(playerManager.canPlayPrevious() ? .white : .gray)
                                .frame(width: 44, height: 44)
                        }
                        .disabled(!playerManager.canPlayPrevious())

                        Button(action: {
                            playerManager.togglePlayPause()
                            HapticManager.shared.selection()
                        }) {
                            Image(systemName: playerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 70))
                        }

                        Button(action: {
                            playerManager.playNext()
                            HapticManager.shared.selection()
                        }) {
                            Image(systemName: "forward.fill")
                                .font(.title)
                                .foregroundColor(playerManager.canPlayNext() ? .white : .gray)
                        }
                        .disabled(!playerManager.canPlayNext())

                        // Recent List Button - Right side
                        Button(action: {
                            showingRecentList = true
                            HapticManager.shared.selection()
                        }) {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.7))
                                .frame(width: 44, height: 44)
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .foregroundColor(.white)
        }
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showingRecentList) {
            RecentPlaylistView()
                .environmentObject(playerManager)
        }
        .onAppear {
            // Sync playlist whenever full player appears
            playerManager.setPlaylistFromRecent(recentTracks)
        }
    }
    
    private func isFavorite(_ id: String) -> Bool {
        favorites.contains { $0.id == id }
    }
    
    private func toggleFavorite(_ track: PlayerManager.MusicTrack) {
        if let existing = favorites.first(where: { $0.id == track.id }) {
            modelContext.delete(existing)
            HapticManager.shared.impact(style: .light)
        } else {
            let newFavorite = MusicTrackEntity(
                id: track.id,
                name: track.name,
                singer: track.singer,
                albumName: track.albumName,
                imageUrl: track.imageUrl,
                audioUrl: track.audioUrl
            )
            modelContext.insert(newFavorite)
            HapticManager.shared.notification(type: .success)
        }
    }
    
    private func formatTime(_ seconds: Double) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", mins, secs)
    }
    
    // MARK: - Lyric Helpers

    private var playModeIcon: String {
        switch playerManager.playMode {
        case .sequential: return "list.bullet"
        case .loopAll:    return "repeat"
        case .loopOne:    return "repeat.1"
        case .shuffle:    return "shuffle"
        }
    }

    private func isCurrentLine(_ line: PlayerManager.LyricLine) -> Bool {
        guard let index = playerManager.parsedLyrics.firstIndex(where: { $0.id == line.id }) else { return false }
        let currentTime = playerManager.currentTime
        
        let startTime = line.time
        let endTime = index + 1 < playerManager.parsedLyrics.count ? playerManager.parsedLyrics[index + 1].time : Double.infinity
        
        return currentTime >= startTime && currentTime < endTime
    }
    

    
    private func activeLineID() -> UUID? {
        playerManager.parsedLyrics.last(where: { $0.time <= playerManager.currentTime })?.id
    }
}


#Preview {
    PlayerView()
        .environmentObject(PlayerManager())
}
