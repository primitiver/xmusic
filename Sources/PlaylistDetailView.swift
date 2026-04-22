import SwiftUI
import SwiftData

struct PlaylistDetailView: View {
    let playlist: MusicApiService.Playlist

    @EnvironmentObject var playerManager: PlayerManager
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RecentTrackEntity.lastPlayed, order: .reverse) var recentTracks: [RecentTrackEntity]

    @State private var songs: [MusicApiService.MusicItem] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: playlist.cover)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "music.note.list")
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                    .clipped()

                    VStack(alignment: .leading, spacing: 8) {
                        Text(playlist.name)
                            .font(.title3.bold())
                            .lineLimit(2)
                        Text(playlist.intro.isEmpty ? "暂无简介" : playlist.intro)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                        HStack(spacing: 12) {
                            Label("\(formatCount(playlist.playCount))", systemImage: "play.fill")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Label("\(playlist.songCount)首", systemImage: "music.note.list")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)

                // Songs list
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
                        Text("该歌单暂无歌曲")
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
                                    AsyncImage(url: URL(string: song.absoluteCover)) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Image(systemName: "music.note")
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: 45, height: 45)
                                    .cornerRadius(8)
                                    .clipped()

                                    VStack(alignment: .leading) {
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
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle(playlist.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if songs.isEmpty {
                fetchSongs()
            }
        }
    }

    private func fetchSongs() {
        isLoading = true
        errorMessage = nil
        MusicApiService.shared.fetchPlaylistSongs(specialid: playlist.specialid) { result in
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

    private func formatCount(_ count: Int) -> String {
        if count >= 10000 {
            return String(format: "%.1f万", Double(count) / 10000.0)
        }
        return "\(count)"
    }
}
