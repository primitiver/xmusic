import Foundation
import Combine

class MusicCacheManager: ObservableObject {
    static let shared = MusicCacheManager()
    
    private let fileManager = FileManager.default
    private let cacheDirectoryName = "MusicCache"
    
    // Publish cache size for UI updates
    @Published var cacheSizeString: String = "0.0 MB"
    
    private var cancellables = Set<AnyCancellable>()
    private var downloadTasks: [String: URLSessionDownloadTask] = [:]
    
    private var cacheDirectory: URL? {
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDirectory.appendingPathComponent(cacheDirectoryName)
    }
    
    private init() {
        createCacheDirectory()
        updateCacheSize()
    }
    
    private func createCacheDirectory() {
        guard let cacheDirectory = cacheDirectory else { return }
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
                print("📁 [Cache] Created cache directory: \(cacheDirectory.path)")
            } catch {
                print("❌ [Cache] Failed to create cache directory: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Public API
    
    func isCached(id: String) -> Bool {
        guard let fileURL = getFileURL(for: id) else { return false }
        return fileManager.fileExists(atPath: fileURL.path)
    }
    
    func cachedURL(for id: String) -> URL? {
        guard let fileURL = getFileURL(for: id), fileManager.fileExists(atPath: fileURL.path) else { return nil }
        return fileURL
    }
    
    func startCaching(url: String, id: String) {
        guard let remoteURL = URL(string: url), !isCached(id: id) else { return }
        
        // Avoid duplicate downloads
        if downloadTasks[id] != nil { return }
        
        print("📥 [Cache] Start downloading: \(id)")
        
        let task = URLSession.shared.downloadTask(with: remoteURL) { [weak self] tempURL, response, error in
            guard let self = self else { return }
            self.downloadTasks.removeValue(forKey: id)
            
            if let error = error {
                print("❌ [Cache] Download failed: \(error.localizedDescription)")
                return
            }
            
            guard let tempURL = tempURL, let destinationURL = self.getFileURL(for: id) else { return }
            
            do {
                if self.fileManager.fileExists(atPath: destinationURL.path) {
                    try self.fileManager.removeItem(at: destinationURL)
                }
                try self.fileManager.moveItem(at: tempURL, to: destinationURL)
                print("✅ [Cache] Cached successfully: \(id)")
                DispatchQueue.main.async {
                    self.updateCacheSize()
                }
            } catch {
                print("❌ [Cache] Save file failed: \(error.localizedDescription)")
            }
        }
        
        downloadTasks[id] = task
        task.resume()
    }
    
    func clearCache() {
        guard let cacheDirectory = cacheDirectory else { return }
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
            }
            print("🧹 [Cache] Cleared all cache")
            updateCacheSize()
        } catch {
            print("❌ [Cache] Clear cache failed: \(error.localizedDescription)")
        }
    }
    
    func updateCacheSize() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self, let cacheDirectory = self.cacheDirectory else { return }
            
            var size: Int64 = 0
            do {
                let fileURLs = try self.fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: [.fileSizeKey])
                for fileURL in fileURLs {
                    if let resourceValues = try? fileURL.resourceValues(forKeys: [.fileSizeKey]),
                       let fileSize = resourceValues.fileSize {
                        size += Int64(fileSize)
                    }
                }
            } catch {
                print("⚠️ [Cache] Calculate size failed: \(error.localizedDescription)")
            }
            
            let mbSize = Double(size) / 1024 / 1024
            let formattedSize = String(format: "%.1f MB", mbSize)
            
            DispatchQueue.main.async {
                self.cacheSizeString = formattedSize
            }
        }
    }
    
    // MARK: - Helper
    
    private func getFileURL(for id: String) -> URL? {
        // Use mp3 extension by default, or could parse from URL if needed. 
        // For simplicity, we assume mp3/audio file.
        // To be safe we could just use the id as filename without extension or with a fixed one.
        // AVPlayer works fine with file URLs even without proper extension sometimes, 
        // but let's append .mp3 for clarity or if AVPlayer requires it.
        return cacheDirectory?.appendingPathComponent("\(id).mp3")
    }
}
