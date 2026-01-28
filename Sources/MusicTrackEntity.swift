import Foundation
import SwiftData

@Model
final class MusicTrackEntity {
    @Attribute(.unique) var id: String
    var name: String
    var singer: String
    var albumName: String?
    var imageUrl: String?
    var audioUrl: String
    var lrcUrl: String?
    var lrc: String?
    var timestamp: Date
    
    init(id: String, name: String, singer: String, albumName: String? = nil, imageUrl: String? = nil, audioUrl: String, lrcUrl: String? = nil, lrc: String? = nil, timestamp: Date = Date()) {
        self.id = id
        self.name = name
        self.singer = singer
        self.albumName = albumName
        self.imageUrl = imageUrl
        self.audioUrl = audioUrl
        self.lrcUrl = lrcUrl
        self.lrc = lrc
        self.timestamp = timestamp
    }
}
