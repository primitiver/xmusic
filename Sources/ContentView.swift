import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0
    @StateObject private var playerManager = PlayerManager()
    @State private var isShowingPlayer = false

    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label("推荐", systemImage: "music.note.house")
                }
                .tag(0)
                
                NavigationStack {
                    SearchView()
                }
                .tabItem {
                    Label("搜索", systemImage: "magnifyingglass")
                }
                .tag(1)
                
                NavigationStack {
                    LibraryView()
                }
                .tabItem {
                    Label("我的", systemImage: "music.note.list")
                }
                .tag(2)
            }
            
            // Mini Player
            MiniPlayerView()
                .offset(y: -50)
                .onTapGesture {
                    if playerManager.currentTrack != nil {
                        isShowingPlayer = true
                    }
                }
        }
        .environmentObject(playerManager)
        .sheet(isPresented: $isShowingPlayer) {
            PlayerView()
                .environmentObject(playerManager)
        }
    }
}

struct HomeView: View {
    @Query(sort: \RecentTrackEntity.lastPlayed, order: .reverse) var recentTracks: [RecentTrackEntity]
    @EnvironmentObject var playerManager: PlayerManager
    @Environment(\.modelContext) private var modelContext

    // 新状态变量
    @State private var rankCategories: [MusicApiService.RankCategory] = []
    @State private var playlists: [MusicApiService.Playlist] = []
    @State private var recommendedSongs: [MusicApiService.MusicItem] = []
    @State private var isLoadingRanks = true
    @State private var isLoadingPlaylists = true
    @State private var isLoadingSongs = true
    @State private var rankError: String?
    @State private var playlistError: String?
    @State private var songsError: String?

    // 2列网格布局
    let gridColumns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                rankSection
                playlistSection
                recommendSongsSection
                if !recentTracks.isEmpty {
                    recentPlayedSection
                }
                Spacer(minLength: 100)
            }
            .padding(.top)
        }
        .navigationTitle("探索")
        .onAppear {
            fetchRankCategories()
            fetchPlaylists()
            fetchRecommendSongs()
        }
    }

    // MARK: 模块1：热门榜单
    private var rankSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("🏆 热门榜单")
                    .font(.title2.bold())
                Spacer()
                NavigationLink("查看全部", destination: RankCategoryView())
                    .font(.subheadline)
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    if isLoadingRanks {
                        rankLoadingView
                    } else if let error = rankError {
                        errorView(error, retry: fetchRankCategories)
                    } else {
                        ForEach(Array(rankCategories.prefix(8))) { rank in
                            rankCard(rank)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var rankLoadingView: some View {
        ForEach(0..<4, id: \.self) { _ in
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 140, height: 100)
        }
    }

    private func rankCard(_ rank: MusicApiService.RankCategory) -> some View {
        NavigationLink(destination: RankSongsView(rankId: rank.id, rankName: rank.name)) {
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: URL(string: rank.cover)) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "chart.bar.fill").font(.system(size: 24)).foregroundColor(.white)
                }
                .frame(width: 140, height: 80)
                .cornerRadius(12)
                .clipped()
                Text(rank.name)
                    .font(.caption.bold())
                    .lineLimit(1)
                    .foregroundColor(.primary)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: 模块2：推荐歌单
    private var playlistSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("🎵 推荐歌单")
                    .font(.title2.bold())
                Spacer()
                NavigationLink("查看全部", destination: PlaylistListView())
                    .font(.subheadline)
            }
            .padding(.horizontal)

            if isLoadingPlaylists {
                playlistLoadingView
            } else if let error = playlistError {
                errorView(error, retry: fetchPlaylists)
            } else if playlists.isEmpty {
                Text("暂无推荐歌单")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                playlistGridView
            }
        }
    }

    private var playlistLoadingView: some View {
        LazyVGrid(columns: gridColumns, spacing: 15) {
            ForEach(0..<6, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 180)
            }
        }
        .padding(.horizontal)
    }

    private var playlistGridView: some View {
        LazyVGrid(columns: gridColumns, spacing: 15) {
            ForEach(playlists) { playlist in
                NavigationLink(destination: PlaylistDetailView(playlist: playlist)) {
                    VStack(alignment: .leading, spacing: 8) {
                        AsyncImage(url: URL(string: playlist.cover)) { image in
                            image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "music.note.list").foregroundColor(.secondary)
                        }
                        .frame(height: 120)
                        .cornerRadius(12)
                        .clipped()
                        .overlay(alignment: .bottomTrailing) {
                            Text("\(playlist.songCount)首")
                                .font(.caption2.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(4)
                                .padding(4)
                        }
                        Text(playlist.name)
                            .font(.subheadline.bold())
                            .lineLimit(1)
                            .foregroundColor(.primary)
                        Text(formatCount(playlist.playCount))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
    }

    // MARK: 模块3：为你推荐
    private var recommendSongsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("✨ 为你推荐")
                .font(.title2.bold())
                .padding(.horizontal)

            if isLoadingSongs {
                recommendLoadingView
            } else if let error = songsError {
                errorView(error, retry: fetchRecommendSongs)
            } else if recommendedSongs.isEmpty {
                Text("暂无推荐歌曲")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                recommendSongsList
            }
        }
    }

    private var recommendLoadingView: some View {
        VStack(spacing: 12) {
            ForEach(0..<5, id: \.self) { _ in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 50, height: 50)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 150, height: 14)
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }

    private var recommendSongsList: some View {
        ForEach(recommendedSongs) { item in
            HStack {
                Button(action: {
                    HapticManager.shared.selection()
                    playTrack(item, from: recommendedSongs)
                }) {
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: item.absoluteCover)) { image in
                            image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "music.note").foregroundColor(.secondary)
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        .clipped()
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline).lineLimit(1).foregroundColor(.primary)
                            Text(item.artist).font(.subheadline).foregroundColor(.secondary)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
                if playerManager.currentTrack?.id == item.id {
                    Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                        .foregroundColor(.accentColor)
                        .frame(width: 24, height: 24)
                } else {
                    Image(systemName: "play.circle")
                        .foregroundColor(.secondary)
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
    }

    // MARK: 模块4：最近播放
    private var recentPlayedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("⏱ 最近播放")
                .font(.title2.bold())
                .padding(.horizontal)

            ForEach(recentTracks.prefix(5)) { item in
                HStack {
                    Button(action: { playRecentTrack(item) }) {
                        HStack {
                            AsyncImage(url: URL(string: (item.imageUrl ?? "").normalizedMusicUrl)) { image in
                                image.resizable().aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Image(systemName: "music.note").foregroundColor(.secondary)
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .clipped()
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline).foregroundColor(.primary)
                                Text(item.singer).font(.subheadline).foregroundColor(.secondary)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    if playerManager.currentTrack?.id == item.id {
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                            .foregroundColor(.accentColor)
                            .frame(width: 24, height: 24)
                    } else {
                        Image(systemName: "play.circle")
                            .foregroundColor(.secondary)
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    // MARK: 通用组件
    private func errorView(_ message: String, retry: @escaping () -> Void) -> some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 30))
                .foregroundColor(.orange)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button("重试") { retry() }
                .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
    }

    private func fetchRankCategories() {
        isLoadingRanks = true
        rankError = nil
        MusicApiService.shared.fetchRankList { result in
            DispatchQueue.main.async {
                isLoadingRanks = false
                switch result {
                case .success(let ranks):
                    self.rankCategories = ranks
                case .failure(let error):
                    self.rankError = error.localizedDescription
                }
            }
        }
    }

    private func fetchPlaylists() {
        isLoadingPlaylists = true
        playlistError = nil
        MusicApiService.shared.fetchRecommendPlaylists(page: 1, pageSize: 10) { result in
            DispatchQueue.main.async {
                isLoadingPlaylists = false
                switch result {
                case .success(let list):
                    self.playlists = list
                case .failure(let error):
                    self.playlistError = error.localizedDescription
                }
            }
        }
    }

    private func fetchRecommendSongs() {
        isLoadingSongs = true
        songsError = nil
        MusicApiService.shared.fetchRecommendSongs(page: 1, pageSize: 10) { result in
            DispatchQueue.main.async {
                isLoadingSongs = false
                switch result {
                case .success(let songs):
                    self.recommendedSongs = songs
                case .failure(let error):
                    self.songsError = error.localizedDescription
                }
            }
        }
    }

    private func formatCount(_ count: Int) -> String {
        if count >= 10000 {
            return String(format: "%.1f万", Double(count) / 10000.0)
        }
        return "\(count)"
    }
    
    private func playTrack(_ item: MusicApiService.MusicItem, from list: [MusicApiService.MusicItem]) {
        // 推荐歌曲的 url 字段可能为空，需要通过搜索 API 解析
        if item.url.isEmpty {
            MusicApiService.shared.resolveKugouPlayUrl(name: item.name, artist: item.artist, hash: item.id) { audioUrl, lrcUrl in
                guard let audioUrl = audioUrl else { return }
                DispatchQueue.main.async {
                    self.playTrackWithUrl(item, audioUrl: audioUrl, lrcUrl: lrcUrl, from: list)
                }
            }
        } else {
            MusicApiService.shared.resolvePlayUrl(url: item.absoluteUrl) { url in
                guard let audioUrl = url else { return }
                DispatchQueue.main.async {
                    self.playTrackWithUrl(item, audioUrl: audioUrl, lrcUrl: nil, from: list)
                }
            }
        }
    }

    private func playTrackWithUrl(_ item: MusicApiService.MusicItem, audioUrl: String, lrcUrl: String? = nil, from list: [MusicApiService.MusicItem]) {
        let trackLrcUrl = lrcUrl?.isEmpty == false ? lrcUrl! : item.absoluteLrc
        let track = PlayerManager.MusicTrack(
            id: item.id,
            name: item.name,
            singer: item.artist,
            albumName: nil,
            imageUrl: item.absoluteCover,
            audioUrl: audioUrl,
            lrcUrl: trackLrcUrl,
            lrc: nil,
            sourceUrl: item.absoluteUrl
        )
        playerManager.play(track: track)
        playerManager.setPlaylistFromRecent(self.recentTracks)
        saveToRecent(track, originalUrl: item.absoluteUrl)
        playerManager.setPlaylistFromRecent(self.recentTracks)

        MusicApiService.shared.fetchLyric(lrcUrl: trackLrcUrl) { lrc in
            if let lyric = lrc {
                DispatchQueue.main.async {
                    playerManager.lyrics = lyric
                    var updated = track
                    updated.lrc = lyric
                    saveToRecent(updated, originalUrl: item.absoluteUrl)
                    playerManager.setPlaylistFromRecent(self.recentTracks)
                }
            }
        }
    }
    
    private func playRecentTrack(_ item: RecentTrackEntity) {
        let tracks = recentTracks.map { entity in
            PlayerManager.MusicTrack(
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

        if let index = tracks.firstIndex(where: { $0.id == item.id }) {
            let targetTrack = tracks[index]
            MusicApiService.shared.resolvePlayUrl(url: targetTrack.audioUrl) { url in
                guard let realUrl = url else { return }
                DispatchQueue.main.async {
                    let updatedTrack = PlayerManager.MusicTrack(
                        id: targetTrack.id,
                        name: targetTrack.name,
                        singer: targetTrack.singer,
                        albumName: targetTrack.albumName,
                        imageUrl: targetTrack.imageUrl,
                        audioUrl: realUrl,
                        lrcUrl: targetTrack.lrcUrl,
                        lrc: targetTrack.lrc,
                        sourceUrl: item.audioUrl
                    )
                    self.playerManager.play(track: updatedTrack)
                    self.saveToRecent(updatedTrack, originalUrl: item.audioUrl)
                    // Sync playlist to recent tracks
                    self.playerManager.setPlaylistFromRecent(self.recentTracks)

                    if item.lrc == nil, let lrcUrl = item.lrcUrl {
                        MusicApiService.shared.fetchLyric(lrcUrl: lrcUrl) { lrc in
                            if let lyric = lrc {
                                DispatchQueue.main.async {
                                    self.playerManager.lyrics = lyric
                                    var withLyric = updatedTrack
                                    withLyric.lrc = lyric
                                    self.saveToRecent(withLyric, originalUrl: item.audioUrl)
                                    self.playerManager.setPlaylistFromRecent(self.recentTracks)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func saveToRecent(_ track: PlayerManager.MusicTrack, originalUrl: String? = nil) {
        // De-duplicate: remove existing entry with same ID
        if let existing = recentTracks.first(where: { $0.id == track.id }) {
            modelContext.delete(existing)
        }
        
        let recent = RecentTrackEntity(
            id: track.id,
            name: track.name,
            singer: track.singer,
            albumName: track.albumName,
            imageUrl: track.imageUrl,
            // Use originalUrl if provided (preferred for persistence), otherwise current track url
            audioUrl: originalUrl ?? track.audioUrl,
            lrcUrl: track.lrcUrl,
            lrc: track.lrc,
            lastPlayed: Date()
        )
        modelContext.insert(recent)
    }
}

struct SearchView: View {
    @State private var searchText = ""
    @State private var results: [MusicApiService.MusicItem] = []
    @State private var selectedSource: MusicApiService.MusicSource = .netease
    @State private var currentPage = 1
    @State private var isFetching = false
    @State private var canLoadMore = true

    @EnvironmentObject var playerManager: PlayerManager
    @Environment(\.modelContext) private var modelContext
    @Query var favorites: [MusicTrackEntity]
    @Query(sort: \RecentTrackEntity.lastPlayed, order: .reverse) var recentTracks: [RecentTrackEntity]
    
    var body: some View {
        VStack(spacing: 0) {
            // Source Picker
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(MusicApiService.MusicSource.allCases, id: \.self) { source in
                        VStack(spacing: 8) {
                            Text(sourceLabel(for: source))
                                .font(.subheadline)
                                .fontWeight(selectedSource == source ? .bold : .regular)
                                .foregroundColor(selectedSource == source ? .accentColor : .secondary)
                            
                            if selectedSource == source {
                                Circle()
                                    .fill(Color.accentColor)
                                    .frame(width: 4, height: 4)
                            } else {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(width: 4, height: 4)
                            }
                        }
                        .onTapGesture {
                            selectedSource = source
                            HapticManager.shared.selection()
                            resetAndSearch()
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            .background(Color(.systemBackground))
            
            List {
                if results.isEmpty {
                    Text(searchText.isEmpty ? "开始搜索你喜欢的音乐" : "未找到结果")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(results) { item in
                        HStack {
                            Button(action: {
                                HapticManager.shared.selection()
                                playTrack(item)
                            }) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text(item.artist)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Spacer()
                            
                            Button(action: {
                                toggleFavorite(item)
                            }) {
                                Image(systemName: isFavorited(item) ? "heart.fill" : "heart")
                                    .foregroundColor(isFavorited(item) ? .red : .gray)
                                    .font(.system(size: 18))
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .padding(.trailing, 4)
                        }
                    }
                    
                    if !results.isEmpty && canLoadMore {
                        HStack {
                            Spacer()
                            if isFetching {
                                ProgressView()
                            } else {
                                Button("加载更多") {
                                    loadMore()
                                }
                                .foregroundColor(.accentColor)
                                .onAppear {
                                    // Auto load when scroll to bottom
                                    loadMore()
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "搜歌、歌手、专辑")
        .onSubmit(of: .search) {
            resetAndSearch()
        }
        .navigationTitle("搜索")
    }
    
    private func resetAndSearch() {
        results = []
        currentPage = 1
        canLoadMore = true
        performSearch()
    }
    
    private func sourceLabel(for source: MusicApiService.MusicSource) -> String {
        switch source {
        case .netease: return "网易云"
        case .qq: return "QQ"
        case .kugou: return "酷狗"
        case .kuwo: return "酷我"
        case .migu: return "咪咕"
        case .qianqian: return "千千"
        }
    }
    
    private func performSearch() {
        guard !isFetching && !searchText.isEmpty else { return }
        isFetching = true
        
        MusicApiService.shared.search(query: searchText, type: selectedSource, page: currentPage) { result in
            DispatchQueue.main.async {
                isFetching = false
                if case .success(let items) = result {
                    if items.isEmpty {
                        canLoadMore = false
                    } else {
                        self.results.append(contentsOf: items)
                        self.currentPage += 1
                        // If we got fewer than default page size (usually 10-20), assume no more
                        if items.count < 10 {
                            canLoadMore = false
                        }
                    }
                } else {
                    canLoadMore = false
                }
            }
        }
    }
    
    private func loadMore() {
        performSearch()
    }
    
    private func playTrack(_ item: MusicApiService.MusicItem) {
        // Build playlist from current search results
        let playlist = results.map { apiItem in
            PlayerManager.MusicTrack(
                id: apiItem.id,
                name: apiItem.name,
                singer: apiItem.artist,
                albumName: nil,
                imageUrl: apiItem.absoluteCover,
                audioUrl: apiItem.absoluteUrl,
                lrcUrl: apiItem.absoluteLrc,
                lrc: nil,
                sourceUrl: apiItem.absoluteUrl
            )
        }

        if let index = playlist.firstIndex(where: { $0.id == item.id }) {
            playerManager.setPlaylist(tracks: playlist, startIndex: index)
        }

        MusicApiService.shared.resolvePlayUrl(url: item.absoluteUrl) { url in
            guard let audioUrl = url else { return }

            DispatchQueue.main.async {
                let track = PlayerManager.MusicTrack(
                    id: item.id,
                    name: item.name,
                    singer: item.artist,
                    albumName: nil,
                    imageUrl: item.absoluteCover,
                    audioUrl: audioUrl,
                    lrcUrl: item.absoluteLrc,
                    lrc: nil,
                    sourceUrl: item.absoluteUrl
                )
                if self.playerManager.currentPlaylist.isEmpty {
                    self.playerManager.play(track: track)
                }
                saveToRecent(track, originalUrl: item.absoluteUrl)
                // Sync playlist to recent tracks
                playerManager.setPlaylistFromRecent(self.recentTracks)

                MusicApiService.shared.fetchLyric(lrcUrl: item.absoluteLrc) { lrc in
                    if let lyric = lrc {
                        DispatchQueue.main.async {
                            playerManager.lyrics = lyric
                            var updatedTrack = track
                            updatedTrack.lrc = lyric
                            saveToRecent(updatedTrack, originalUrl: item.absoluteUrl)
                            playerManager.setPlaylistFromRecent(self.recentTracks)
                        }
                    } else {
                        DispatchQueue.main.async {
                            playerManager.lyrics = ""
                        }
                    }
                }
            }
        }
    }
    
    private func saveToRecent(_ track: PlayerManager.MusicTrack, originalUrl: String? = nil) {
        // De-duplicate using FetchDescriptor
        let trackId = track.id
        let descriptor = FetchDescriptor<RecentTrackEntity>(predicate: #Predicate { $0.id == trackId })
        if let items = try? modelContext.fetch(descriptor), let existing = items.first {
            modelContext.delete(existing)
        }
        
        let recent = RecentTrackEntity(
            id: track.id,
            name: track.name,
            singer: track.singer,
            albumName: track.albumName,
            imageUrl: track.imageUrl,
            audioUrl: originalUrl ?? track.audioUrl,
            lrcUrl: track.lrcUrl,
            lrc: track.lrc,
            lastPlayed: Date()
        )
        modelContext.insert(recent)
    }
    
    private func isFavorited(_ item: MusicApiService.MusicItem) -> Bool {
        favorites.contains { $0.id == item.id }
    }
    
    private func toggleFavorite(_ item: MusicApiService.MusicItem) {
        if let existingIndex = favorites.firstIndex(where: { $0.id == item.id }) {
            modelContext.delete(favorites[existingIndex])
            HapticManager.shared.notification(type: .success)
        } else {
            // Save with absoluteUrl (unresolved) so we can resolve it fresh when playing from favorites
            let favorite = MusicTrackEntity(
                id: item.id,
                name: item.name,
                singer: item.artist,
                albumName: nil,
                imageUrl: item.absoluteCover,
                audioUrl: item.absoluteUrl,
                lrcUrl: item.absoluteLrc,
                lrc: nil
            )
            modelContext.insert(favorite)
            
            // Also try to fetch lyrics to save them
            MusicApiService.shared.fetchLyric(lrcUrl: item.absoluteLrc) { lrc in
                if let lyric = lrc {
                    DispatchQueue.main.async {
                        favorite.lrc = lyric
                    }
                }
            }
            
            HapticManager.shared.notification(type: .success)
        }
    }
}

struct LibraryView: View {
    @Query(sort: \MusicTrackEntity.timestamp, order: .reverse) var favorites: [MusicTrackEntity]
    @Query(sort: \RecentTrackEntity.lastPlayed, order: .reverse) var recentTracks: [RecentTrackEntity]
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var playerManager: PlayerManager
    
    @StateObject private var cacheManager = MusicCacheManager.shared
    
    var body: some View {
        List {
            // Cache Management Section
            Section(header: Text("存储空间")) {
                HStack {
                    Text("缓存占用")
                    Spacer()
                    Text(cacheManager.cacheSizeString)
                        .foregroundColor(.secondary)
                }
                
                Button(action: {
                    cacheManager.clearCache()
                    HapticManager.shared.notification(type: .success)
                }) {
                    Text("清除缓存")
                        .foregroundColor(.red)
                }
            }
            
            Section(header: Text("我的收藏")) {
                if favorites.isEmpty {
                    Text("暂无收藏,快去搜索你喜欢的音乐吧")
                        .foregroundColor(.secondary)
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(favorites) { item in
                        HStack {
                            Button(action: {
                                playTrack(item)
                            }) {
                                HStack {
                                    AsyncImage(url: URL(string: (item.imageUrl ?? "").normalizedMusicUrl)) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Image(systemName: "music.note")
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                    .clipped()
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text(item.singer)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Spacer()
                            
                            NavigationLink(destination: DetailListView(title: item.singer, query: item.singer)
                                .environmentObject(playerManager)) {
                                EmptyView()
                            }
                            .frame(width: 10)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
        .navigationTitle("媒体库")
    }
    
    private func playTrack(_ item: MusicTrackEntity) {
        // Resolve the URL before playback to ensure it's fresh/valid
        MusicApiService.shared.resolvePlayUrl(url: item.audioUrl) { url in
            guard let audioUrl = url else { return }

            DispatchQueue.main.async {
                let track = PlayerManager.MusicTrack(
                    id: item.id,
                    name: item.name,
                    singer: item.singer,
                    albumName: item.albumName,
                    imageUrl: item.imageUrl,
                    audioUrl: audioUrl,
                    lrcUrl: item.lrcUrl,
                    lrc: item.lrc,
                    sourceUrl: item.audioUrl
                )
                playerManager.play(track: track)
                // Sync playlist to recent tracks
                playerManager.setPlaylistFromRecent(self.recentTracks)

                // If content is missing but URL exists, fetch it
                if item.lrc == nil, let lrcUrl = item.lrcUrl {
                     MusicApiService.shared.fetchLyric(lrcUrl: lrcUrl) { lrc in
                        if let lyric = lrc {
                            DispatchQueue.main.async {
                                playerManager.lyrics = lyric
                                item.lrc = lyric
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(favorites[index])
            }
        }
    }
}

struct MiniPlayerView: View {
    @EnvironmentObject var playerManager: PlayerManager
    @Query(sort: \RecentTrackEntity.lastPlayed, order: .reverse) var recentTracks: [RecentTrackEntity]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if let track = playerManager.currentTrack {
                    AsyncImage(url: URL(string: (track.imageUrl ?? "").normalizedMusicUrl)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "music.note")
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 45, height: 45)
                    .cornerRadius(8)
                    .clipped()
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(track.name)
                            .font(.system(size: 15, weight: .semibold))
                            .lineLimit(1)

                        HStack(spacing: 4) {
                            Text(track.singer)
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)

                            Text("•")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .fixedSize()

                            Text("\(formatTime(playerManager.currentTime)) / \(formatTime(playerManager.duration))")
                                .font(.system(size: 11, design: .monospaced))
                                .foregroundColor(.secondary)
                                .fixedSize()
                        }
                    }
                } else {
                    Image(systemName: "music.note")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text("未在播放")
                            .font(.system(size: 15, weight: .semibold))
                        Text("选择歌曲开始播放")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    // Previous Button
                    Button(action: {
                        playerManager.playPrevious()
                        HapticManager.shared.selection()
                    }) {
                        Image(systemName: "backward.fill")
                            .font(.title3)
                            .foregroundColor(playerManager.canPlayPrevious() ? .primary : .secondary.opacity(0.3))
                    }
                    .disabled(!playerManager.canPlayPrevious())

                    // Play/Pause Button
                    Button(action: {
                        playerManager.togglePlayPause()
                        HapticManager.shared.selection()
                    }) {
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    // Next Button
                    Button(action: {
                        playerManager.playNext()
                        HapticManager.shared.selection()
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.title3)
                            .foregroundColor(playerManager.canPlayNext() ? .primary : .secondary.opacity(0.3))
                    }
                    .disabled(!playerManager.canPlayNext())

                    // Play Mode Button
                    Button(action: {
                        playerManager.togglePlayMode()
                        HapticManager.shared.selection()
                    }) {
                        Image(systemName: playModeIcon)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.trailing, 5)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            
            // Progress Bar at the bottom
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.primary.opacity(0.1))
                    
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: geo.size.width * CGFloat(playerManager.currentTime / max(playerManager.duration, 1)))
                }
            }
            .frame(height: 3)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.1), radius: 10, y: 5)
        .onAppear {
            // Sync playlist whenever mini player appears (handles recent list changes)
            playerManager.setPlaylistFromRecent(recentTracks)
        }
    }
    
    private func formatTime(_ seconds: Double) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", mins, secs)
    }

    private var playModeIcon: String {
        switch playerManager.playMode {
        case .sequential: return "list.bullet"
        case .loopAll:    return "repeat"
        case .loopOne:    return "repeat.1"
        case .shuffle:    return "shuffle"
        }
    }
}

#Preview {
    ContentView()
}
