import SwiftUI

struct PlaylistListView: View {
    @State private var playlists: [MusicApiService.Playlist] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var currentPage = 1
    @State private var isLoadingMore = false
    @State private var hasMore = true
    @State private var selectedCategory = 0
    @State private var selectedGenre = 0

    private let categories = ["全部", "热门", "华语", "粤语", "欧美", "日语", "韩语"]
    private let genres = ["流行", "经典", "伤感", "甜蜜", "DJ", "轻音乐", "网络"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 分类筛选
                categoryFilterSection
                genreFilterSection

                if isLoading {
                    playlistLoadingView(count: 10)
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
                            fetchPlaylists(reset: true)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 60)
                } else if playlists.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "music.note")
                            .font(.system(size: 40))
                            .foregroundColor(.secondary)
                        Text("暂无推荐歌单")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 60)
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(playlists) { playlist in
                            NavigationLink(destination: PlaylistDetailView(playlist: playlist)) {
                                VStack(alignment: .leading, spacing: 10) {
                                    AsyncImage(url: URL(string: playlist.cover)) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Image(systemName: "music.note.list")
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: 160, height: 160)
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
                                    }

                                    Text(playlist.name)
                                        .font(.headline)
                                        .lineLimit(2)
                                        .foregroundColor(.primary)

                                    Text(formatCount(playlist.playCount))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)

                    if isLoadingMore {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else if hasMore {
                        Color.clear
                            .frame(height: 1)
                            .onAppear {
                                loadMore()
                            }
                    } else {
                        Text("— 已经到底啦 —")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle("推荐歌单")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            if playlists.isEmpty {
                fetchPlaylists(reset: true)
            }
        }
    }

    private var categoryFilterSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("语种")
                .font(.headline)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedCategory = index
                                fetchPlaylists(reset: true)
                            }
                        }) {
                            Text(category)
                                .font(.subheadline.bold())
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(selectedCategory == index ? Color.accentColor : Color.gray.opacity(0.15))
                                .foregroundColor(selectedCategory == index ? .white : .primary)
                                .cornerRadius(16)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var genreFilterSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("曲风")
                .font(.headline)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(genres.enumerated()), id: \.offset) { index, genre in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedGenre = index
                                fetchPlaylists(reset: true)
                            }
                        }) {
                            Text(genre)
                                .font(.subheadline.bold())
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(selectedGenre == index ? Color.accentColor : Color.gray.opacity(0.15))
                                .foregroundColor(selectedGenre == index ? .white : .primary)
                                .cornerRadius(16)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var gridColumns: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }

    private func playlistLoadingView(count: Int) -> some View {
        LazyVGrid(columns: gridColumns, spacing: 15) {
            ForEach(0..<count, id: \.self) { _ in
                VStack(alignment: .leading, spacing: 10) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 160, height: 160)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 120, height: 16)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 80, height: 12)
                }
                .padding(.horizontal)
            }
        }
    }

    private func fetchPlaylists(reset: Bool = false) {
        if reset {
            currentPage = 1
            playlists = []
            hasMore = true
        }
        isLoading = reset ? true : false
        errorMessage = nil

        let keyword = buildKeyword()
        MusicApiService.shared.fetchRecommendPlaylists(page: currentPage, pageSize: 20, keyword: keyword) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let items):
                    if reset {
                        self.playlists = items
                    } else {
                        self.playlists.append(contentsOf: items)
                    }
                    if items.count < 20 {
                        hasMore = false
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                isLoadingMore = false
            }
        }
    }

    private func buildKeyword() -> String {
        let cat = categories[selectedCategory]
        let gen = genres[selectedGenre]
        if cat == "全部" && gen == "流行" { return "热门" }
        if cat == "全部" { return gen }
        if gen == "流行" { return cat }
        return "\(cat)\(gen)"
    }

    private func loadMore() {
        guard !isLoadingMore && hasMore else { return }
        isLoadingMore = true
        currentPage += 1
        fetchPlaylists()
    }

    private func formatCount(_ count: Int) -> String {
        if count >= 10000 {
            return String(format: "%.1f万", Double(count) / 10000.0)
        }
        return "\(count)"
    }
}
