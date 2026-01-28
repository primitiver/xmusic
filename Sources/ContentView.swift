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
    @State private var recommendedTracks: [MusicApiService.MusicItem] = []
    
    let discoveryItems = [
        ("甄选歌单", "music.note.list", Color.blue),
        ("排行榜", "chart.bar.fill", Color.orange),
        ("新歌速递", "sparkles", Color.purple),
        ("电台", "radio.fill", Color.green)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Header
                Text("大家都在听")
                    .font(.title2.bold())
                    .padding(.horizontal)
                
                // Discovery Horizontal Scroll
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(discoveryItems, id: \.0) { item in
                            NavigationLink(destination: DetailListView(title: item.0, query: item.0)) {
                                VStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(item.2.gradient)
                                            .frame(width: 120, height: 120)
                                        
                                        Image(systemName: item.1)
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)
                                    }
                                    Text(item.0)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                }
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.selection()
                            })
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Recently Played
                if !recentTracks.isEmpty {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("最近播放")
                            .font(.title2.bold())
                            .padding(.horizontal)
                        
                        ForEach(recentTracks.prefix(5)) { item in
                            HStack {
                                Button(action: {
                                    playRecentTrack(item)
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
                                
                                NavigationLink(destination: DetailListView(title: item.singer, query: item.singer)) {
                                    Image(systemName: "play.circle")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                // Recommendations (Dynamic from Script)
                VStack(alignment: .leading, spacing: 15) {
                    Text("为你推荐")
                        .font(.title2.bold())
                        .padding(.horizontal)
                    
                    if recommendedTracks.isEmpty {
                        Text("正在生成个性化推荐...")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .onAppear {
                                fetchRecommendations()
                            }
                    } else {
                        ForEach(recommendedTracks) { item in
                            HStack {
                                Button(action: {
                                    HapticManager.shared.selection()
                                    playTrack(item)
                                }) {
                                    HStack(spacing: 15) {
                                        AsyncImage(url: URL(string: item.absoluteCover)) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            Image(systemName: "music.note")
                                                .foregroundColor(.secondary)
                                        }
                                        .frame(width: 55, height: 55)
                                        .cornerRadius(10)
                                        .clipped()
                                        
                                        VStack(alignment: .leading) {
                                            Text(item.name)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            Text(item.artist)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                Spacer(minLength: 100)
            }
            .padding(.top)
        }
        .navigationTitle("探索")
        .onAppear {
            fetchRecommendations()
        }
    }
    
    private func fetchRecommendations() {
        MusicApiService.shared.search(query: "2024热歌") { result in
            if case .success(let items) = result {
                DispatchQueue.main.async {
                    self.recommendedTracks = Array(items.prefix(10))
                }
            }
        }
    }
    
    private func playTrack(_ item: MusicApiService.MusicItem) {
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
                    lrc: nil
                )
                playerManager.play(track: track)
                // Save the original source URL (item.absoluteUrl) for persistence, 
                // so we can re-resolve it later (e.g. from Recent or Favorites)
                saveToRecent(track, originalUrl: item.absoluteUrl)
                
                // Fetch lyric too
                MusicApiService.shared.fetchLyric(lrcUrl: item.absoluteLrc) { lrc in
                    if let lyric = lrc {
                        DispatchQueue.main.async {
                            playerManager.lyrics = lyric
                            var updated = track
                            updated.lrc = lyric
                            saveToRecent(updated, originalUrl: item.absoluteUrl)
                        }
                    }
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
                lrc: entity.lrc
            )
        }
        
        if let index = tracks.firstIndex(where: { $0.id == item.id }) {
            // Resolve the target track's URL because Recent list might store unresolved source URLs
            let targetTrack = tracks[index]
            MusicApiService.shared.resolvePlayUrl(url: targetTrack.audioUrl) { url in
                guard let realUrl = url else { return }
                DispatchQueue.main.async {
                    var playableTracks = tracks
                    // Update the target track with the fresh resolved URL
                    let updatedTrack = PlayerManager.MusicTrack(
                        id: targetTrack.id,
                        name: targetTrack.name,
                        singer: targetTrack.singer,
                        albumName: targetTrack.albumName,
                        imageUrl: targetTrack.imageUrl,
                        audioUrl: realUrl,
                        lrcUrl: targetTrack.lrcUrl,
                        lrc: targetTrack.lrc
                    )
                    playableTracks[index] = updatedTrack
                    
                    self.playerManager.setPlaylist(tracks: playableTracks, startIndex: index)
                    // Update recent time, keeping the original URL (which is in item.audioUrl)
                    self.saveToRecent(updatedTrack, originalUrl: item.audioUrl)
                    
                    // If content missing but URL exists, fetch it
                    if item.lrc == nil, let lrcUrl = item.lrcUrl {
                        MusicApiService.shared.fetchLyric(lrcUrl: lrcUrl) { lrc in
                            if let lyric = lrc {
                                DispatchQueue.main.async {
                                    self.playerManager.lyrics = lyric
                                    var withLyric = updatedTrack
                                    withLyric.lrc = lyric
                                    self.saveToRecent(withLyric, originalUrl: item.audioUrl)
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
                    lrc: nil
                )
                playerManager.play(track: track)
                saveToRecent(track, originalUrl: item.absoluteUrl)
                
                // Fetch lyric
                MusicApiService.shared.fetchLyric(lrcUrl: item.absoluteLrc) { lrc in
                    if let lyric = lrc {
                        DispatchQueue.main.async {
                            playerManager.lyrics = lyric
                            // Update the track in player and save with content
                            var updatedTrack = track
                            updatedTrack.lrc = lyric
                            saveToRecent(updatedTrack, originalUrl: item.absoluteUrl)
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
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var playerManager: PlayerManager
    
    var body: some View {
        List {
            
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
                    lrc: item.lrc
                )
                playerManager.play(track: track)
                
                // If content is missing but URL exists, fetch it
                if item.lrc == nil, let lrcUrl = item.lrcUrl {
                     MusicApiService.shared.fetchLyric(lrcUrl: lrcUrl) { lrc in
                        if let lyric = lrc {
                            DispatchQueue.main.async {
                                playerManager.lyrics = lyric
                                // Optionally update entity with content
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
                            
                            Text("•")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text("\(formatTime(playerManager.currentTime)) / \(formatTime(playerManager.duration))")
                                .font(.system(size: 11, design: .monospaced))
                                .foregroundColor(.secondary)
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
    }
    
    private func formatTime(_ seconds: Double) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", mins, secs)
    }
}

#Preview {
    ContentView()
}
