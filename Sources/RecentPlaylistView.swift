import SwiftUI
import SwiftData

struct RecentPlaylistView: View {
    @Query(sort: \RecentTrackEntity.lastPlayed, order: .reverse) 
    var recentTracks: [RecentTrackEntity]
    
    @Query var favorites: [MusicTrackEntity]
    
    @EnvironmentObject var playerManager: PlayerManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                if recentTracks.isEmpty {
                    Text("暂无播放记录")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(recentTracks) { item in
                        Button(action: {
                            playFromList(item)
                        }) {
                            HStack(spacing: 12) {
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
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(item.singer)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                if isCurrentTrack(item) {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .foregroundColor(.accentColor)
                                        .font(.caption)
                                }
                                
                                Button(action: {
                                    toggleFavorite(item)
                                }) {
                                    Image(systemName: isFavorite(item.id) ? "heart.fill" : "heart")
                                        .foregroundColor(isFavorite(item.id) ? .red : .gray)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                deleteRecent(item)
                            } label: {
                                Label("删除", systemImage: "trash")
                            }
                            
                            Button {
                                toggleFavorite(item)
                            } label: {
                                let isFav = isFavorite(item.id)
                                Label(isFav ? "取消收藏" : "收藏", systemImage: isFav ? "heart.slash" : "heart")
                            }
                            .tint(isFavorite(item.id) ? .gray : .red)
                        }
                    }
                }
            }
            .navigationTitle("最近播放")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完成") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func isCurrentTrack(_ item: RecentTrackEntity) -> Bool {
        playerManager.currentTrack?.id == item.id
    }
    
    private func playFromList(_ item: RecentTrackEntity) {
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
            playerManager.setPlaylist(tracks: tracks, startIndex: index)
        }
        
        dismiss()
    }
    
    private func deleteRecent(_ item: RecentTrackEntity) {
        withAnimation {
            modelContext.delete(item)
        }
    }
    
    private func isFavorite(_ id: String) -> Bool {
        favorites.contains { $0.id == id }
    }
    
    private func toggleFavorite(_ item: RecentTrackEntity) {
        if let existing = favorites.first(where: { $0.id == item.id }) {
            modelContext.delete(existing)
            HapticManager.shared.impact(style: .light)
        } else {
            let newFavorite = MusicTrackEntity(
                id: item.id,
                name: item.name,
                singer: item.singer,
                albumName: item.albumName,
                imageUrl: item.imageUrl,
                audioUrl: item.audioUrl
            )
            modelContext.insert(newFavorite)
            HapticManager.shared.notification(type: .success)
        }
    }
}
