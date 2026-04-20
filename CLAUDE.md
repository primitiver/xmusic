# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Rules
1. 所有输出必须使用中文。

## Project Overview

Xmusic is an iOS music player app built with SwiftUI, SwiftData, and AVFoundation. It targets iOS 15.0+ and uses Xcode for building (no SPM or third-party dependencies).

## Build & Run Commands

- **Build**: `xcodebuild -project Xmusic.xcodeproj -scheme Xmusic -configuration Debug build`
- **Build for simulator**: `xcodebuild -project Xmusic.xcodeproj -scheme Xmusic -destination 'platform=iOS Simulator,name=iPhone 16' build`
- **Clean**: `xcodebuild -project Xmusic.xcodeproj -scheme Xmusic clean`
- **Run tests**: No test target currently exists in the project.
- **Open in Xcode**: `open Xmusic.xcodeproj`

## Architecture

### App Entry Point
- `Sources/XmusicApp.swift` — SwiftUI `@main` entry. Sets up `SwiftData` model container for `MusicTrackEntity` and `RecentTrackEntity`.

### Views (all in `Sources/`)
- `ContentView.swift` — Root view with a 3-tab `TabView` (推荐/Home, 搜索/Search, 我的/Library), mini player overlay, and full `PlayerView` sheet. Contains `HomeView`, `SearchView`, `LibraryView`, and `MiniPlayerView` as embedded structs.
- `PlayerView.swift` — Full-screen player with album art/lyrics `TabView` paging, progress slider, playback controls, and favorite toggle.
- `RecentPlaylistView.swift` — Sheet view showing recent play history with swipe-to-delete and favorite actions.
- `DetailListView.swift` — Generic list view for discovery categories (热歌, 排行榜, etc.) that searches the API and displays results.

### Services (all in `Sources/`)
- `PlayerManager.swift` — `ObservableObject` wrapping `AVPlayer`. Manages playback, time tracking, lyrics parsing, playlist navigation, Now Playing info center, and remote command center (lock screen controls). Persists last played state via `UserDefaults`.
- `MusicApiService.swift` — Singleton for the music search/playback API at `https://www.jbsou.cn/`. Provides `search()`, `resolvePlayUrl()` (handles redirect interception), and `fetchLyric()`. Uses callback-based async (not `async/await`).
- `MusicCacheManager.swift` — Singleton `ObservableObject` that downloads and caches audio files to `Documents/MusicCache/`. Used by `PlayerManager` to check cache before fetching remote URLs.
- `HapticManager.swift` — Singleton wrapping UIKit haptic feedback generators.

### Models (all in `Sources/`)
- `MusicTrackEntity.swift` — SwiftData `@Model` for favorites (persisted with timestamp).
- `RecentTrackEntity.swift` — SwiftData `@Model` for play history (persisted with lastPlayed date).

### Utilities
- `String+Extensions.swift` — `normalizedMusicUrl` computed property for resolving relative/protocol-relative URLs.

### Key Patterns
- **URL Resolution Flow**: API returns source URLs that may redirect. `resolvePlayUrl()` intercepts HTTP redirects via a custom `URLSessionDelegate` to extract the final playable URL.
- **Cache-First Playback**: `PlayerManager.play()` checks `MusicCacheManager` for local files before using remote URLs. Caching happens asynchronously in the background.
- **Persistence Strategy**: Favorites and recent plays use SwiftData. Last played track/playlist state uses `UserDefaults` with `Codable` encoding.
- **State Management**: `PlayerManager` is a `@StateObject` at the `ContentView` level, passed down via `@EnvironmentObject`. API calls use completion handlers, dispatched to main queue for UI updates.
- **Lyrics**: Parsed from LRC format in `PlayerManager.parseLyrics()`. `PlayerView` auto-scrolls to the active lyric line based on `currentTime`.

## File Layout

```
Sources/
  XmusicApp.swift          # App entry + SwiftData container
  ContentView.swift         # TabView, HomeView, SearchView, LibraryView, MiniPlayerView
  PlayerView.swift          # Full-screen player
  RecentPlaylistView.swift  # Recent history sheet
  DetailListView.swift      # Discovery category list
  PlayerManager.swift       # AVPlayer wrapper + playback logic
  MusicApiService.swift     # Music search/play API client
  MusicCacheManager.swift   # Audio file caching
  HapticManager.swift       # Haptic feedback
  MusicTrackEntity.swift    # Favorites model
  RecentTrackEntity.swift   # Play history model
  String+Extensions.swift   # URL normalization
  Assets.xcassets/          # App icon, colors
```
