import SwiftUI
import SwiftData

@main
struct XmusicApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [MusicTrackEntity.self, RecentTrackEntity.self])
    }
}
