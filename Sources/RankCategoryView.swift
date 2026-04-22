import SwiftUI
import SwiftData

struct RankCategoryView: View {
    @EnvironmentObject var playerManager: PlayerManager
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RecentTrackEntity.lastPlayed, order: .reverse) var recentTracks: [RecentTrackEntity]

    @State private var categories: [MusicApiService.RankCategory] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if isLoading {
                    VStack(spacing: 15) {
                        ForEach(0..<5, id: \.self) { _ in
                            HStack(spacing: 15) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                VStack(alignment: .leading, spacing: 8) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 150, height: 16)
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 100, height: 12)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                } else if let error = errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                        Text("加载失败")
                            .font(.headline)
                        Text(error)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button("重试") {
                            fetchCategories()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 60)
                } else if categories.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "music.note")
                            .font(.system(size: 40))
                            .foregroundColor(.secondary)
                        Text("暂无榜单数据")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 60)
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(categories) { category in
                            NavigationLink(destination: RankSongsView(rankId: category.id, rankName: category.name)) {
                                VStack(alignment: .leading, spacing: 10) {
                                    AsyncImage(url: URL(string: category.cover)) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Image(systemName: "music.note.list")
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: 160, height: 160)
                                    .cornerRadius(12)
                                    .clipped()

                                    Text(category.name)
                                        .font(.headline)
                                        .lineLimit(2)
                                        .foregroundColor(.primary)

                                    Text("更新: \(category.updateTime)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .navigationTitle("热门榜单")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            if categories.isEmpty {
                fetchCategories()
            }
        }
    }

    private func fetchCategories() {
        isLoading = true
        errorMessage = nil
        MusicApiService.shared.fetchRankList { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let ranks):
                    self.categories = ranks
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct RankSongsView: View {
    let rankId: String
    let rankName: String

    @EnvironmentObject var playerManager: PlayerManager
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RecentTrackEntity.lastPlayed, order: .reverse) var recentTracks: [RecentTrackEntity]

    @State private var songs: [MusicApiService.MusicItem] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if isLoading {
                    VStack(spacing: 15) {
                        ForEach(0..<10, id: \.self) { _ in
                            HStack(spacing: 15) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading, spacing: 8) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 150, height: 14)
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 100, height: 12)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                } else if let error = errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                        Text("加载失败")
                            .font(.headline)
                        Text(error)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button("重试") {
                            fetchSongs()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 60)
                } else if songs.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "music.note")
                            .font(.system(size: 40))
                            .foregroundColor(.secondary)
                        Text("该榜单暂无歌曲")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 60)
                } else {
                    ForEach(Array(songs.enumerated()), id: \.element.id) { index, song in
                        HStack {
                            Text("\(index + 1)")
                                .font(.subheadline.bold())
                                .foregroundColor(.secondary)
                                .frame(width: 30, alignment: .center)

                            Button(action: {
                                HapticManager.shared.selection()
                                playTrack(song, from: songs)
                            }) {
                                HStack(spacing: 12) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(song.name)
                                            .font(.headline)
                                            .lineLimit(1)
                                            .foregroundColor(.primary)
                                        Text(song.artist)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())

                            Spacer()

                            Text(formatDuration(song))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle(rankName)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            if songs.isEmpty {
                fetchSongs()
            }
        }
    }

    private func fetchSongs() {
        isLoading = true
        errorMessage = nil
        MusicApiService.shared.fetchRankSongs(rankId: rankId) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let items):
                    self.songs = items
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func playTrack(_ item: MusicApiService.MusicItem, from list: [MusicApiService.MusicItem]) {
        // Kugou songs need URL resolution via search
        if item.url.isEmpty {
            print("🎵 [RankSongs] Resolving Kugou URL for: \(item.name)")
            MusicApiService.shared.resolveKugouPlayUrl(name: item.name, artist: item.artist, hash: item.id) { audioUrl, lrcUrl in
                guard let audioUrl = audioUrl else {
                    print("❌ [RankSongs] Failed to resolve Kugou URL")
                    return
                }
                print("✅ [RankSongs] Got audio URL, playing: \(item.name)")
                DispatchQueue.main.async {
                    self.playTrackWithUrl(item, audioUrl: audioUrl, lrcUrl: lrcUrl, from: list)
                }
            }
        } else {
            print("🎵 [RankSongs] Resolving jbsou URL for: \(item.name)")
            MusicApiService.shared.resolvePlayUrl(url: item.absoluteUrl) { url in
                guard let audioUrl = url else {
                    print("❌ [RankSongs] Failed to resolve jbsou URL")
                    return
                }
                DispatchQueue.main.async {
                    self.playTrackWithUrl(item, audioUrl: audioUrl, from: list)
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

    private func saveToRecent(_ track: PlayerManager.MusicTrack, originalUrl: String? = nil) {
        if let existing = recentTracks.first(where: { $0.id == track.id }) {
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

    private func formatDuration(_ item: MusicApiService.MusicItem) -> String {
        if let duration = item.duration {
            let mins = Int(duration) / 60
            let secs = Int(duration) % 60
            return String(format: "%d:%02d", mins, secs)
        }
        return "--:--"
    }
}
