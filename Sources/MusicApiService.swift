import Foundation

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
        
        enum CodingKeys: String, CodingKey {
            case songid, name, artist, lrc, url, cover, link
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
            if trimmed.hasPrefix("http") { return trimmed }
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
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                // Try UTF8 first
                if let lrc = String(data: data, encoding: .utf8) {
                    print("📥 [MusicApi] Lyric Received (\(lrc.count) chars)")
                    completion(lrc)
                } else {
                    // Fallback to GBK/GB18030 if UTF8 fails (common for Chinese lyrics)
                    let gbkEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
                    if let lrc = String(data: data, encoding: String.Encoding(rawValue: gbkEncoding)) {
                        print("📥 [MusicApi] Lyric Received (GBK/GB18030 fallback)")
                        completion(lrc)
                    } else {
                        print("❌ [MusicApi] Failed to decode lyric data")
                        completion(nil)
                    }
                }
            } else {
                print("❌ [MusicApi] No lyric data received")
                completion(nil)
            }
        }.resume()
    }
    
    private lazy var resolveSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: config, delegate: RedirectHandler(), delegateQueue: nil)
    }()
    
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
