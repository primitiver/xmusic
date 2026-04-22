import Foundation
import Compression

class MusicApiService {
    static let shared = MusicApiService()
    private let baseURL = "https://www.jbsou.cn/"
    
    enum MusicSource: String, CaseIterable {
        case netease = "netease"
        case qq = "qq"
        case kugou = "kugou"
        case kuwo = "kuwo"
        case migu = "migu"
        case qianqian = "qianqian"
    }
    
    struct SearchResult: Codable {
        let data: [MusicItem]
        let code: Int
        let error: String?
    }
    
    struct MusicItem: Codable, Identifiable {
        var id: String { 
            songid ?? url 
        }
        let songid: String?
        let name: String
        let artist: String
        let lrc: String
        let url: String
        let cover: String
        let link: String?
        var duration: Int?

        enum CodingKeys: String, CodingKey {
            case songid, name, artist, lrc, url, cover, link, duration
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Handle songid being Int or String, store as String
            if let stringVal = try? container.decode(String.self, forKey: .songid) {
                songid = stringVal
            } else if let intVal = try? container.decode(Int.self, forKey: .songid) {
                songid = String(intVal)
            } else {
                songid = nil
            }
            
            name = (try? container.decode(String.self, forKey: .name)) ?? "未知"
            artist = (try? container.decode(String.self, forKey: .artist)) ?? "未知"
            lrc = (try? container.decode(String.self, forKey: .lrc)) ?? ""
            url = (try? container.decode(String.self, forKey: .url)) ?? ""
            cover = (try? container.decode(String.self, forKey: .cover)) ?? ""
            link = try? container.decode(String.self, forKey: .link)
            duration = try? container.decode(Int.self, forKey: .duration)
        }

        // Manual memberwise initializer for creating MusicItem from Kugou data
        init(songid: String?, name: String, artist: String, lrc: String, url: String, cover: String, link: String?) {
            self.songid = songid
            self.name = name
            self.artist = artist
            self.lrc = lrc
            self.url = url
            self.cover = cover
            self.link = link
            self.duration = nil
        }

        // Helper to set duration manually (for Kugou songs)
        func settingDuration(_ d: Int) -> MusicItem {
            var copy = self
            copy.duration = d
            return copy
        }
        
        // Helper to get absolute URLs
        var absoluteUrl: String { 
            let trimmed = url.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.hasPrefix("http") { return trimmed }
            if trimmed.hasPrefix("//") { return "https:" + trimmed }
            return "https://www.jbsou.cn/" + (trimmed.hasPrefix("/") ? String(trimmed.dropFirst()) : trimmed)
        }
        var absoluteLrc: String {
            let trimmed = lrc.trimmingCharacters(in: .whitespacesAndNewlines)
            // If it's already a full URL, use as-is
            if trimmed.hasPrefix("http") { return trimmed }
            // If it's a jbsou.cn api.php path with sign/t, prepend base URL
            if (trimmed.hasPrefix("api.php") || trimmed.hasPrefix("/api.php")) && trimmed.contains("sign=") {
                let clean = trimmed.hasPrefix("/") ? String(trimmed.dropFirst()) : trimmed
                return "https://www.jbsou.cn/" + clean
            }
            // If it looks like a hash (hex string, 32 chars), try to extract sign/t from url field
            if trimmed.count == 32 && trimmed.range(of: "^[0-9a-fA-F]+$", options: .regularExpression) != nil {
                let urlTrimmed = url.trimmingCharacters(in: .whitespacesAndNewlines)
                if let signRange = urlTrimmed.range(of: "sign="),
                   let tRange = urlTrimmed.range(of: "&t=") {
                    // Extract sign value (between sign= and &t=)
                    let signEnd = signRange.upperBound
                    let signValue = String(urlTrimmed[signEnd..<tRange.lowerBound])
                    let tStart = tRange.upperBound
                    let tValue = String(urlTrimmed[tStart...])
                    return "https://www.jbsou.cn/api.php?get=lrc&type=kg&id=\(trimmed)&sign=\(signValue)&t=\(tValue)"
                }
                // Fallback: no sign/t, will fail but at least build the URL
                return "https://www.jbsou.cn/api.php?get=lrc&type=kg&id=\(trimmed)"
            }
            if trimmed.hasPrefix("//") { return "https:" + trimmed }
            return "https://www.jbsou.cn/" + (trimmed.hasPrefix("/") ? String(trimmed.dropFirst()) : trimmed)
        }
        var absoluteCover: String { 
            let trimmed = cover.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.hasPrefix("http") { return trimmed }
            if trimmed.hasPrefix("//") { return "https:" + trimmed }
            return "https://www.jbsou.cn/" + (trimmed.hasPrefix("/") ? String(trimmed.dropFirst()) : trimmed)
        }
    }
    
    func search(query: String, type: MusicSource = .netease, page: Int = 1, completion: @escaping (Result<[MusicItem], Error>) -> Void) {
        let url = URL(string: baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Headers requested by the API
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        request.setValue("application/json, text/javascript, */*; q=0.01", forHTTPHeaderField: "Accept")
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
        request.setValue("https://www.jbsou.cn/", forHTTPHeaderField: "Referer")
        
        let bodyParameters = [
            "input": query,
            "filter": "name",
            "type": type.rawValue,
            "page": String(page)
        ]
        
        let bodyString = bodyParameters.map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }.joined(separator: "&")
        request.httpBody = bodyString.data(using: .utf8)
        
        print("🌐 [MusicApi] Searching: \(query) on \(type.rawValue)")
        print("📤 [MusicApi] Parameters: \(bodyString)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            // Log raw response for debugging
            if let json = String(data: data, encoding: .utf8) { 
                print("📥 [MusicApi] Raw Response: \(json)") 
            }
            
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                if result.code == 200 {
                    completion(.success(result.data))
                } else {
                    let msg = result.error ?? "Unknown API Error"
                    completion(.failure(NSError(domain: "MusicApi", code: result.code, userInfo: [NSLocalizedDescriptionKey: msg])))
                }
            } catch {
                print("❌ [MusicApi] Decoding Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchLyric(lrcUrl: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: lrcUrl) else {
            completion(nil)
            return
        }
        print("🌐 [MusicApi] Fetching Lyric from: \(lrcUrl)")

        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
        request.setValue("https://www.jbsou.cn/", forHTTPHeaderField: "Referer")

        URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data else {
                print("❌ [MusicApi] No lyric data received")
                completion(nil)
                return
            }

            print("📥 [MusicApi] Lyric raw data size: \(data.count) bytes")

            // 尝试 gzip 解压
            let processedData: Data
            if let decompressed = self.decompressGzipData(data) {
                print("📥 [MusicApi] Lyric gzip decompressed: \(data.count) -> \(decompressed.count) bytes")
                processedData = decompressed
            } else {
                processedData = data
            }

            // 解码响应
            let rawString = String(data: processedData, encoding: .utf8) ?? {
                let gbk = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                return String(data: processedData, encoding: String.Encoding(rawValue: gbk))
            }() ?? ""

            let trimmedRaw = rawString.trimmingCharacters(in: .whitespacesAndNewlines)
            print("📥 [MusicApi] Lyric decoded (\(rawString.count) chars): \(String(trimmedRaw.prefix(200)))")

            // 如果是 HTML 则跳过
            if trimmedRaw.hasPrefix("<") || rawString.contains("<html") || rawString.contains("<!DOCTYPE") {
                print("⚠️ [MusicApi] Lyric response is HTML, skipping")
                completion(nil)
                return
            }

            // 接受任何非空、非 HTML 的响应作为歌词
            if !rawString.isEmpty && rawString.count > 10 {
                print("📥 [MusicApi] Lyric Received (\(rawString.count) chars)")
                completion(rawString)
            } else {
                print("⚠️ [MusicApi] Lyric content too short or empty")
                completion(nil)
            }
        }.resume()
    }

    /// Fetch lyric from Kugou official API: search -> download -> decompress
    private func fetchKugouLyric(url: URL, completion: @escaping (String?) -> Void) {
        print("🎤 [Lyric] Searching Kugou lyrics: \(url.absoluteString)")
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
        request.setValue("https://www.jbsou.cn/", forHTTPHeaderField: "Referer")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, _ in
            guard let data = data, let self = self else {
                print("❌ [Lyric] No search response data")
                completion(nil)
                return
            }

            // Log raw search response
            if let rawStr = String(data: data, encoding: .utf8) {
                print("📥 [Lyric] Search response: \(String(rawStr.prefix(300)))")
            }

            // Parse search response: {"candidates": [{"id": xxx, "accesskey": "xxx", "duration": xxx, "score": xxx}, ...], "status": 200}
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let candidates = json["candidates"] as? [[String: Any]] else {
                print("⚠️ [Lyric] Kugou lyric search response parsing failed")
                completion(nil)
                return
            }

            if candidates.isEmpty {
                print("⚠️ [Lyric] Kugou lyric search returned no candidates")
                completion(nil)
                return
            }

            guard let first = candidates.first,
                  let accesskey = first["accesskey"] as? String,
                  let id = first["id"] as? String else {
                print("⚠️ [Lyric] Kugou lyric candidate missing accesskey or id: \(candidates.first ?? [:])")
                completion(nil)
                return
            }

            print("🎤 [Lyric] Found candidate: id=\(id), accesskey=\(accesskey), downloading...")
            let downloadUrl = URL(string: "https://lyrics.kugou.com/download?ver=1&man=yes&client=pc&accesskey=\(accesskey)&id=\(id)")!
            print("🎤 [Lyric] Download URL: \(downloadUrl.absoluteString)")
            var dlRequest = URLRequest(url: downloadUrl)
            dlRequest.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
            dlRequest.setValue("https://www.jbsou.cn/", forHTTPHeaderField: "Referer")

            URLSession.shared.dataTask(with: dlRequest) { downloadData, _, _ in
                guard let downloadData = downloadData else {
                    print("❌ [Lyric] No lyric download data")
                    completion(nil)
                    return
                }

                print("📥 [Lyric] Downloaded data: \(downloadData.count) bytes")

                // Kugou returns gzipped content
                if let decompressed = self.decompressGzipData(downloadData) {
                    print("📥 [Lyric] Decompressed: \(downloadData.count) -> \(decompressed.count) bytes")
                    if let lrc = String(data: decompressed, encoding: .utf8) {
                        print("📥 [Lyric] ✅ Kugou Lyric Received (\(lrc.count) chars): \(String(lrc.prefix(100)))")
                        completion(lrc)
                    } else if let lrc = String(data: decompressed, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))) {
                        print("📥 [Lyric] ✅ Kugou Lyric Received GBK (\(lrc.count) chars): \(String(lrc.prefix(100)))")
                        completion(lrc)
                    } else {
                        print("❌ [Lyric] Failed to decode decompressed lyric")
                        completion(nil)
                    }
                } else {
                    print("⚠️ [Lyric] Decompression failed, trying direct decode")
                    // Not gzipped, try direct decode
                    if let lrc = String(data: downloadData, encoding: .utf8) {
                        print("📥 [Lyric] ✅ Direct Lyric Received (\(lrc.count) chars): \(String(lrc.prefix(100)))")
                        completion(lrc)
                    } else {
                        print("❌ [Lyric] Failed to decompress or decode lyric data")
                        completion(nil)
                    }
                }
            }.resume()
        }.resume()
    }

    /// Decompress gzip/deflate data using Swift Compression framework
    private func decompressGzipData(_ data: Data) -> Data? {
        guard data.count >= 18 else { return nil }

        let outputBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count * 10)
        defer { outputBuffer.deallocate() }

        let decompressedSize = data.withUnsafeBytes { sourcePtr -> Int in
            let sourceBuffer = sourcePtr.bindMemory(to: UInt8.self).baseAddress!
            // Try gzip first (COMPRESSION_ZLIB handles gzip format on iOS)
            return compression_decode_buffer(
                outputBuffer, data.count * 10,
                sourceBuffer, data.count,
                nil, COMPRESSION_ZLIB
            )
        }

        guard decompressedSize != 0 else { return nil }
        return Data(bytes: outputBuffer, count: decompressedSize)
    }
    
    private lazy var resolveSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: config, delegate: RedirectHandler(), delegateQueue: nil)
    }()
    
    // MARK: - 酷狗专用接口

    // MARK: 热门榜单列表模型
    struct RankCategory: Codable, Identifiable {
        let rankid: Int
        var id: String { String(rankid) }
        let name: String
        let rawCover: String
        var cover: String { rawCover.replacingOccurrences(of: "{size}", with: "200") }
        let updateTime: String
        let intro: String

        enum CodingKeys: String, CodingKey {
            case rankid
            case name = "rankname"
            case rawCover = "imgurl"
            case updateTime = "rank_id_publish_date"
            case intro
        }
    }

    // MARK: 推荐歌单模型
    struct Playlist: Codable, Identifiable {
        let specialid: Int
        var id: String { String(specialid) }
        let name: String
        let rawCover: String
        var cover: String { rawCover.replacingOccurrences(of: "{size}", with: "200") }
        let playCount: Int
        let songCount: Int
        let intro: String

        enum CodingKeys: String, CodingKey {
            case specialid
            case name = "specialname"
            case rawCover = "imgurl"
            case playCount = "playcount"
            case songCount = "songcount"
            case intro
        }
    }

    // MARK: 酷狗 API 通用响应
    struct KugouResponse<T: Codable>: Codable {
        let status: Int
        let data: T?
        let errmsg: String?
    }

    struct KugouRankListData: Codable {
        let list: [RankCategory]?

        enum CodingKeys: String, CodingKey {
            case list = "info"
        }
    }

    struct KugouSongListData: Codable {
        let list: [KugouRankSongInfo]?

        enum CodingKeys: String, CodingKey {
            case list = "info"
        }
    }

    // 榜单歌曲专用模型（API返回小写驼峰字段）
    struct KugouRankSongInfo: Codable {
        let songname: String
        let filename: String
        let hash: String
        let duration: Int
        let rawCover: String?

        enum CodingKeys: String, CodingKey {
            case songname
            case filename
            case hash
            case duration
            case rawCover = "album_sizable_cover"
        }

        var cover: String {
            guard let raw = rawCover else { return "" }
            return raw.replacingOccurrences(of: "{size}", with: "200")
        }

        // 从 filename 解析歌手（格式："歌手 - 歌名"）
        var artist: String {
            let parts = filename.split(separator: " - ", maxSplits: 1)
            if parts.count == 2 {
                return String(parts[0])
            }
            return "未知"
        }

        func toMusicItem() -> MusicItem {
            var item = MusicItem(
                songid: hash,
                name: songname,
                artist: artist,
                lrc: hash,
                url: "",
                cover: cover,
                link: nil
            )
            item.duration = duration
            return item
        }
    }

    struct KugouPlaylistData: Codable {
        let list: [Playlist]?

        enum CodingKeys: String, CodingKey {
            case list = "info"
        }
    }

    struct KugouRecommendSongData: Codable {
        let lists: [KugouSongInfo]?

        struct KugouSongInfo: Codable {
            let songname: String
            let singername: String
            let hash: String
            let album_name: String?
            let rawImgurl: String?
            var imgurl: String? { rawImgurl?.replacingOccurrences(of: "{size}", with: "200") }
            let duration: Int

            enum CodingKeys: String, CodingKey {
                case songname = "SongName"
                case singername = "SingerName"
                case hash = "FileHash"
                case album_name = "AlbumName"
                case rawImgurl = "Image"
                case duration = "Duration"
            }
        }
    }

    // MARK: 1. 热门榜单列表接口
    func fetchRankList(completion: @escaping (Result<[RankCategory], Error>) -> Void) {
        let urlString = "http://mobilecdnbj.kugou.com/api/v3/rank/list?version=9108&plat=0&showtype=2&parentid=0&apiver=6&area_code=1&withsong=0&with_res_tag=0"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        print("🌐 [MusicApi] Fetching rank list: \(urlString)")
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                if let json = String(data: data, encoding: .utf8) {
                    print("📥 [MusicApi] Rank List Raw Response: \(String(json.prefix(500)))...")
                }
                let response = try JSONDecoder().decode(KugouResponse<KugouRankListData>.self, from: data)
                if response.status == 1, let list = response.data?.list {
                    completion(.success(list))
                } else {
                    let msg = response.errmsg ?? "Unknown error"
                    completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: msg])))
                }
            } catch {
                print("❌ [MusicApi] Rank List Decoding Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: 2. 榜单详情接口
    func fetchRankSongs(rankId: String, completion: @escaping (Result<[MusicItem], Error>) -> Void) {
        let urlString = "http://mobilecdnbj.kugou.com/api/v3/rank/song?version=9108&ranktype=0&plat=0&pagesize=100&area_code=1&page=1&volid=35050&rankid=\(rankId)&with_res_tag=0"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        print("🌐 [MusicApi] Fetching rank songs for rankId: \(rankId)")
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                if let json = String(data: data, encoding: .utf8) {
                    print("📥 [MusicApi] Rank Songs Raw Response: \(String(json.prefix(500)))...")
                }
                let response = try JSONDecoder().decode(KugouResponse<KugouSongListData>.self, from: data)
                if response.status == 1, let list = response.data?.list {
                    let items = list.map { $0.toMusicItem() }
                    completion(.success(items))
                } else {
                    let msg = response.errmsg ?? "Unknown error"
                    completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: msg])))
                }
            } catch {
                print("❌ [MusicApi] Rank Songs Decoding Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: 3. 推荐歌单接口
    func fetchRecommendPlaylists(page: Int = 1, pageSize: Int = 10, keyword: String = "热门", completion: @escaping (Result<[Playlist], Error>) -> Void) {
        var components = URLComponents(string: "http://mobilecdn.kugou.com/api/v3/search/special")!
        components.queryItems = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "keyword", value: keyword),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pagesize", value: String(pageSize)),
            URLQueryItem(name: "showtype", value: "1")
        ]
        let url = components.url!
        print("🌐 [MusicApi] Fetching recommend playlists: \(url.absoluteString)")
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                if let json = String(data: data, encoding: .utf8) {
                    print("📥 [MusicApi] Playlists Raw Response: \(String(json.prefix(500)))...")
                }
                let response = try JSONDecoder().decode(KugouResponse<KugouPlaylistData>.self, from: data)
                if response.status == 1, let list = response.data?.list {
                    completion(.success(list))
                } else {
                    let msg = response.errmsg ?? "Unknown error"
                    completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: msg])))
                }
            } catch {
                print("❌ [MusicApi] Playlists Decoding Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: 5. 歌单歌曲接口
    func fetchPlaylistSongs(specialid: Int, completion: @escaping (Result<[MusicItem], Error>) -> Void) {
        var components = URLComponents(string: "http://mobilecdn.kugou.com/api/v3/special/song")!
        components.queryItems = [
            URLQueryItem(name: "specialid", value: String(specialid)),
            URLQueryItem(name: "pagesize", value: "50"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "area_code", value: "1")
        ]
        let url = components.url!
        print("🌐 [MusicApi] Fetching playlist songs for specialid: \(specialid)")
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                if let json = String(data: data, encoding: .utf8) {
                    print("📥 [MusicApi] Playlist Songs Raw Response: \(String(json.prefix(1000)))...")
                }
                let decoder = JSONDecoder()
                // Playlist songs API returns {"data": {"info": [...]}} without status wrapper
                let wrapper = try decoder.decode(PlaylistSongsWrapper.self, from: data)
                let items = wrapper.data.info.map { song -> MusicItem in
                    let artist = song.filename.split(separator: " - ", maxSplits: 1).first.map { String($0) } ?? "未知"
                    return MusicItem(
                        songid: song.hash,
                        name: song.remark.isEmpty ? song.filename : song.remark,
                        artist: artist,
                        lrc: song.hash,
                        url: "",
                        cover: song.cover,
                        link: nil
                    )
                }
                completion(.success(items))
            } catch {
                print("❌ [MusicApi] Playlist Songs Decoding Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    // 歌单歌曲响应包装（无status字段）
    struct PlaylistSongsWrapper: Codable {
        let data: PlaylistSongsData
    }

    struct PlaylistSongsData: Codable {
        let info: [PlaylistSongInfo]
    }

    struct PlaylistSongInfo: Codable {
        let hash: String
        let filename: String
        let remark: String
        let duration: Int
        let rawCover: String?
        let extraCover: String?
        let albumAudioId: Int?

        enum CodingKeys: String, CodingKey {
            case hash, filename, remark, duration
            case rawCover = "album_sizable_cover"
            case extraCover = "sizable_cover"
            case albumAudioId = "album_audio_id"
        }

        var cover: String {
            if let raw = rawCover?.replacingOccurrences(of: "{size}", with: "200"), !raw.isEmpty { return raw }
            if let raw = extraCover?.replacingOccurrences(of: "{size}", with: "200"), !raw.isEmpty { return raw }
            // Fallback: construct URL from album_audio_id
            if let albumId = albumAudioId, albumId > 0 {
                return "http://imge.kugou.com/stdmusic/200/\(albumId).jpg"
            }
            return ""
        }
    }

    // MARK: 4. 推荐歌曲接口
    func fetchRecommendSongs(page: Int = 1, pageSize: Int = 10, completion: @escaping (Result<[MusicItem], Error>) -> Void) {
        var components = URLComponents(string: "https://songsearch.kugou.com/song_search_v2")!
        components.queryItems = [
            URLQueryItem(name: "keyword", value: "热门歌曲"),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pagesize", value: String(pageSize)),
            URLQueryItem(name: "userid", value: "0"),
            URLQueryItem(name: "clientver", value: ""),
            URLQueryItem(name: "platform", value: "WebFilter"),
            URLQueryItem(name: "filter", value: "2"),
            URLQueryItem(name: "iscorrection", value: "1"),
            URLQueryItem(name: "privilege_filter", value: "0"),
            URLQueryItem(name: "area_code", value: "1")
        ]
        let url = components.url!
        print("🌐 [MusicApi] Fetching recommend songs: \(url.absoluteString)")
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                if let json = String(data: data, encoding: .utf8) {
                    print("📥 [MusicApi] Recommend Songs Raw Response: \(String(json.prefix(500)))...")
                }
                let response = try JSONDecoder().decode(KugouResponse<KugouRecommendSongData>.self, from: data)
                if response.status == 1, let songInfos = response.data?.lists {
                    // Convert KugouSongInfo to MusicItem
                    let items = songInfos.map { info in
                        MusicItem(
                            songid: info.hash,
                            name: info.songname,
                            artist: info.singername,
                            lrc: "",
                            url: "",
                            cover: info.imgurl ?? "",
                            link: nil
                        )
                    }
                    completion(.success(items))
                } else {
                    let msg = response.errmsg ?? "Unknown error"
                    completion(.failure(NSError(domain: "MusicApi", code: -1, userInfo: [NSLocalizedDescriptionKey: msg])))
                }
            } catch {
                print("❌ [MusicApi] Recommend Songs Decoding Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - 酷狗歌曲播放地址解析
    /// 返回播放 URL 和歌词 URL（带 sign/t），如果歌词 URL 不可用则返回空字符串
    func resolveKugouPlayUrl(name: String, artist: String, hash: String, completion: @escaping (String?, String?) -> Void) {
        let query = artist.isEmpty ? name : "\(artist) - \(name)"
        print("🌐 [MusicApi] Resolving Kugou play URL via search: \(query)")
        search(query: query, type: .kugou, page: 1) { result in
            switch result {
            case .success(let items):
                if let first = items.first, !first.url.isEmpty {
                    // jbsou.cn API URL directly returns MP3 binary data, use it as playable URL
                    let playUrl = first.absoluteUrl
                    print("✅ [MusicApi] Kugou Play URL: \(playUrl)")
                    // 从搜索结果的 lrc 或 url 字段提取带 sign/t 的歌词 URL
                    let lyricUrl = self.extractLrcUrl(from: first)
                    completion(playUrl, lyricUrl)
                } else {
                    print("❌ [MusicApi] Kugou search returned no URL for: \(query)")
                    completion(nil, nil)
                }
            case .failure(let error):
                print("❌ [MusicApi] Kugou search error: \(error.localizedDescription)")
                completion(nil, nil)
            }
        }
    }

    /// 从搜索结果中提取带 sign/t 的歌词 URL
    private func extractLrcUrl(from item: MusicItem) -> String {
        let trimmed = item.lrc.trimmingCharacters(in: .whitespacesAndNewlines)
        // lrc 字段已经包含 api.php 路径带 sign/t
        if (trimmed.hasPrefix("api.php") || trimmed.hasPrefix("/api.php")) && trimmed.contains("sign=") {
            let clean = trimmed.hasPrefix("/") ? String(trimmed.dropFirst()) : trimmed
            return "https://www.jbsou.cn/" + clean
        }
        // 如果 lrc 是 hash，从 url 字段提取 sign/t
        if trimmed.count == 32 && trimmed.range(of: "^[0-9a-fA-F]+$", options: .regularExpression) != nil {
            let urlTrimmed = item.url.trimmingCharacters(in: .whitespacesAndNewlines)
            if let signRange = urlTrimmed.range(of: "sign="),
               let tRange = urlTrimmed.range(of: "&t=") {
                let signValue = String(urlTrimmed[signRange.upperBound..<tRange.lowerBound])
                let tValue = String(urlTrimmed[tRange.upperBound...])
                return "https://www.jbsou.cn/api.php?get=lrc&type=kg&id=\(trimmed)&sign=\(signValue)&t=\(tValue)"
            }
        }
        return trimmed
    }

    // The API might return a redirect URL or a JSON with the URL
    func resolvePlayUrl(url: String, completion: @escaping (String?) -> Void) {
        guard let requestUrl = URL(string: url) else {
            print("❌ [MusicApi] Invalid URL: \(url)")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
        request.setValue("https://www.jbsou.cn/", forHTTPHeaderField: "Referer")
        request.setValue("application/json, text/javascript, */*; q=0.01", forHTTPHeaderField: "Accept")
        
        print("🌐 [MusicApi] Resolving Play URL (No Redirect): \(url)")
        
        resolveSession.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ [MusicApi] Resolve Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("📥 [MusicApi] Resolve StatusCode: \(httpResponse.statusCode)")
                
                // Try all variations of "Location" case
                let locationKeys = ["Location", "location", "LOCATION"]
                for key in locationKeys {
                    if let location = httpResponse.allHeaderFields[key] as? String {
                        print("🔗 [MusicApi] Found Location Header (\(key)): \(location)")
                        completion(location)
                        return
                    }
                }
                
                // If it followed the redirect (which it shouldn't due to delegate) and got a 200
                if httpResponse.statusCode == 200 {
                    let finalUrl = httpResponse.url?.absoluteString ?? url
                    print("✅ [MusicApi] Final Play URL: \(finalUrl)")
                    completion(finalUrl)
                    return
                }
            }
            
            // Backup: parse JSON if it's not a redirect
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let finalUrl = json["url"] as? String {
                print("🔗 [MusicApi] Found URL in JSON: \(finalUrl)")
                completion(finalUrl)
                return
            }
            
            print("⚠️ [MusicApi] Could not resolve a play URL")
            completion(nil)
        }.resume()
    }
}

// Helper class to stop URLSession from following redirects
private class RedirectHandler: NSObject, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        // Stop the redirect and return nil to use the current response
        print("🛑 [MusicApi] Intercepted redirect to: \(newRequest.url?.absoluteString ?? "unknown")")
        completionHandler(nil)
    }
}
