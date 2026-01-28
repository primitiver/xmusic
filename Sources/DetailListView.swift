import SwiftUI
import SwiftData

struct DetailListView: View {
    let title: String
    let query: String
    @State private var results: [MusicApiService.MusicItem] = []
    @State private var currentPage = 1
    @State private var isFetching = false
    @State private var canLoadMore = true
    
    @EnvironmentObject var playerManager: PlayerManager
    @Environment(\.modelContext) private var modelContext
    @Query var favorites: [MusicTrackEntity]
    
    var body: some View {
        List {
            if results.isEmpty {
                HStack {
                    Spacer()
                    ProgressView("正在加载 \(title) 的作品...")
                    Spacer()
                }
                .listRowBackground(Color.clear)
            } else {
                ForEach(results) { item in
                    HStack {
                        Button(action: {
                            HapticManager.shared.selection()
                            playTrack(item)
                        }) {
                            HStack {
                                AsyncImage(url: URL(string: item.absoluteCover)) { image in
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
                                    Text(item.artist)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
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
                                loadMore()
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
            }
        }
        .navigationTitle(title)
        .onAppear {
            performSearch()
        }
    }

    private func performSearch() {
        guard !isFetching else { return }
        isFetching = true
        
        var searchQuery = query
        if query == "排行榜" { searchQuery = "抖音热歌" }
        else if query == "甄选歌单" { searchQuery = "热歌" }
        else if query == "新歌速递" { searchQuery = "新歌" }
        else if query == "电台" { searchQuery = "经典" }
        
        MusicApiService.shared.search(query: searchQuery, page: currentPage) { result in
            DispatchQueue.main.async {
                isFetching = false
                if case .success(let items) = result {
                    if items.isEmpty {
                        canLoadMore = false
                    } else {
                        self.results.append(contentsOf: items)
                        self.currentPage += 1
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
                            var updated = track
                            updated.lrc = lyric
                            saveToRecent(updated, originalUrl: item.absoluteUrl)
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
            // Save with absoluteUrl (unresolved)
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
