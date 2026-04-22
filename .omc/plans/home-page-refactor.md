# 首页重构与完善 — 工作规划

## 需求概述

根据 `doc.md` 中定义的酷狗 API 接口，全面重构首页（HomeView）功能，将当前以通用搜索接口为主的首页改造为使用专用接口的内容流式布局。

### 接口映射关系

| 模块 | doc.md 接口 | 当前实现 | 目标 |
|------|------------|---------|------|
| 热门榜单列表 | 接口1: `/api/v3/rank/list` | 缺失 | 新增 |
| 榜单详情 | 接口4: `/api/v3/rank/song` | 缺失 | 新增 |
| 推荐歌单 | 接口2: `/api/v3/search/special` | 用通用 search 替代 | 专用接口 |
| 推荐歌曲 | 接口3: `/song_search_v2` | 用 search("2024热歌") 替代 | 专用接口 |
| 最近播放 | 本地 SwiftData | 已有 | 保留 |

---

## 新首页布局结构（从上到下）

```
┌─────────────────────────────────┐
│  热门榜单 (横向滚动卡片列表)      │  ← 新增
├─────────────────────────────────┤
│  推荐歌单 (2列网格布局)           │  ← 替换发现网格
├─────────────────────────────────┤
│  为你推荐 (歌曲列表, 10条)       │  ← 保留,改用专用接口
├─────────────────────────────────┤
│  最近播放 (最多5条)              │  ← 保留不变
└─────────────────────────────────┘
        MiniPlayerView (浮动)
```

---

## 验收标准

1. 首页加载时自动请求热门榜单列表接口，展示至少 3 个榜单卡片
2. 点击榜单卡片跳转到榜单详情页，展示该榜单的前 100 首歌曲
3. 推荐歌单使用推荐歌单接口获取，以 2 列网格展示至少 10 个歌单
4. 为你推荐模块使用推荐歌曲接口获取，展示至少 10 首歌曲
5. 所有模块有加载状态和错误处理（空数据/网络错误提示）
6. 最近播放模块功能不受影响
7. 点击歌曲能正常播放、加入最近播放记录

---

## 实现步骤

### Step 1: 扩展 MusicApiService — 新增接口方法

**文件**: `Sources/MusicApiService.swift`

新增以下方法：

#### 1.1 `fetchRankList(completion:)` — 热门榜单列表接口
- URL: `http://mobilecdnbj.kugou.com/api/v3/rank/list?version=9108&plat=0&showtype=2&parentid=0&apiver=6&area_code=1&withsong=0&with_res_tag=0`
- 返回模型: `RankCategory` 数组
  ```swift
  struct RankCategory: Codable, Identifiable {
      let id: String        // rankid
      let name: String      // 榜单名称
      let cover: String     // 封面图URL
      let updateTime: String // 更新时间
      let intro: String     // 简介
  }
  ```

#### 1.2 `fetchRankSongs(rankId:completion:)` — 榜单详情接口
- URL: `http://mobilecdnbj.kugou.com/api/v3/rank/song?version=9108&ranktype=0&plat=0&pagesize=100&area_code=1&page=1&volid=35050&rankid={rankId}&with_res_tag=0`
- 返回模型: 复用现有 `MusicItem`（接口返回格式与 search 一致）

#### 1.3 `fetchRecommendPlaylists(page:pageSize:completion:)` — 推荐歌单接口
- URL: `http://mobilecdn.kugou.com/api/v3/search/special?format=json&keyword=热门&page={page}&pagesize={pageSize}&showtype=1`
- 返回模型: `Playlist` 数组
  ```swift
  struct Playlist: Codable, Identifiable {
      let id: String        // 歌单ID
      let name: String      // 歌单名称
      let cover: String     // 封面图URL
      let playCount: Int    // 播放量
      let songCount: Int    // 歌曲数量
      let intro: String     // 简介
  }
  ```

#### 1.4 `fetchRecommendSongs(page:pageSize:completion:)` — 推荐歌曲接口
- URL: `https://songsearch.kugou.com/song_search_v2?keyword=热门歌曲&page={page}&pagesize={pageSize}&userid=0&clientver=&platform=WebFilter&filter=2&iscorrection=1&privilege_filter=0&area_code=1`
- 返回模型: 复用现有 `MusicItem`

### Step 2: 新增 RankCategoryView — 榜单详情页

**新建文件**: `Sources/RankCategoryView.swift`

- 展示热门榜单分类列表（接口1返回数据）
- 垂直滚动，每个榜单卡片包含：封面图、名称、更新时间
- 点击榜单卡片 → 导航到 `RankSongsView(rankId: rankId, rankName: name)`

### Step 3: 新建 RankSongsView — 榜单歌曲列表页

**新建文件**: `Sources/RankSongsView.swift`

- 展示指定榜单的歌曲列表（接口4返回数据）
- 使用 `DetailListView` 的类似布局，但数据来源为 `fetchRankSongs`
- 支持点击播放、加入播放列表

### Step 4: 新建 PlaylistDetailView — 歌单详情页

**新建文件**: `Sources/PlaylistDetailView.swift`

- 展示指定歌单的歌曲列表
- 数据来源：复用现有 `MusicApiService.search(query: playlistName)` 或后续扩展
- 顶部显示歌单封面、名称、简介、播放量

### Step 5: 重构 HomeView — 全新布局

**文件**: `Sources/ContentView.swift`（重写 HomeView 部分）

#### 5.1 删除现有模块
- 删除 `discoveryItems` 发现网格模块
- 删除旧的 `fetchRecommendations()` 方法

#### 5.2 新增状态变量
```swift
@State private var rankCategories: [MusicApiService.RankCategory] = []
@State private var playlists: [MusicApiService.Playlist] = []
@State private var recommendedSongs: [MusicApiService.MusicItem] = []
@State private var isLoadingRanks = false
@State private var isLoadingPlaylists = false
@State private var isLoadingSongs = false
```

#### 5.3 新增数据加载方法
- `fetchRankCategories()` — 调用 `fetchRankList`
- `fetchPlaylists()` — 调用 `fetchRecommendPlaylists(page: 1, pageSize: 10)`
- `fetchRecommendSongs()` — 调用 `fetchRecommendSongs(page: 1, pageSize: 10)`

#### 5.4 新增视图模块
1. **热门榜单模块**: 横向 ScrollView，每个卡片显示封面+名称+更新时间，点击导航到 RankCategoryView
2. **推荐歌单模块**: LazyVGrid 2列网格，每个卡片显示封面+名称+播放量+歌曲数，点击导航到 PlaylistDetailView
3. **为你推荐模块**: 垂直列表，复用现有歌曲行渲染逻辑，但数据来源改为 `fetchRecommendSongs`
4. **最近播放模块**: 保留现有逻辑不变

### Step 6: 更新 ContentView 导航

**文件**: `Sources/ContentView.swift`

- HomeView 的 NavigationLink 目标更新为新的视图
- 确保所有新建视图能正确访问 PlayerManager（通过 @EnvironmentObject）

---

## 文件变更清单

| 操作 | 文件 | 说明 |
|------|------|------|
| 修改 | `Sources/MusicApiService.swift` | 新增 4 个接口方法 + 2 个数据模型 |
| 新建 | `Sources/RankCategoryView.swift` | 热门榜单分类列表页 |
| 新建 | `Sources/RankSongsView.swift` | 榜单歌曲详情页 |
| 新建 | `Sources/PlaylistDetailView.swift` | 歌单详情页 |
| 修改 | `Sources/ContentView.swift` | 重写 HomeView，替换发现网格为推荐歌单 |

---

## 风险与缓解措施

| 风险 | 影响 | 缓解措施 |
|------|------|---------|
| 酷狗接口返回格式与预期不符 | 数据解析失败 | 添加详细的错误日志，打印原始 JSON 便于调试；使用可选解析避免崩溃 |
| 接口跨域或 HTTP 限制 | 请求失败 | 酷狗接口为 HTTP 协议，需在 Info.plist 配置 ATS 例外或使用混合加载 |
| 接口变更或下线 | 功能不可用 | 保留当前 search 接口作为 fallback，专用接口失败时自动降级 |
| 图片加载性能 | 首页卡顿 | 使用 AsyncImage 懒加载，避免提前下载所有封面图 |
| ContextView 文件过大 | 维护困难 | HomeView 拆分为独立文件，ContentView 仅保留 TabView 骨架 |

---

## 验证步骤

1. 构建项目无编译错误：`xcodebuild -project Xmusic.xcodeproj -scheme Xmusic -configuration Debug build`
2. 首页加载后展示 4 个模块：热门榜单、推荐歌单、为你推荐、最近播放
3. 点击榜单卡片进入榜单详情，能展示歌曲列表
4. 点击歌单卡片进入歌单详情，能展示歌曲列表
5. 点击任意歌曲能正常播放
6. 播放后最近播放模块更新
7. 网络异常时各模块显示加载失败提示
8. 模拟器上滑动流畅，无卡顿

---

## 接口汇总表

| 模块 | 接口地址 | 请求方式 | 用途 |
|------|----------|----------|------|
| 热门榜单列表 | `http://mobilecdnbj.kugou.com/api/v3/rank/list` | GET | 首页榜单分类展示 |
| 推荐歌单 | `http://mobilecdn.kugou.com/api/v3/search/special` | GET | 首页歌单推荐板块 |
| 推荐歌曲 | `https://songsearch.kugou.com/song_search_v2` | GET | 首页热门歌曲推荐 |
| 榜单歌曲详情 | `http://mobilecdnbj.kugou.com/api/v3/rank/song` | GET | 榜单内歌曲列表 |
