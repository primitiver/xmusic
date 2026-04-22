

# 1. 热门榜单列表接口
## 接口信息
- 接口名称：酷狗全部榜单分类列表
- LX 音源方法：`getTopLists()`
- 接口地址：
```
http://mobilecdnbj.kugou.com/api/v3/rank/list
```
- 请求方式：`GET`

## 请求参数
| 参数名 | 参数值 | 类型 | 说明 |
|--------|--------|------|------|
| version | 9108 | string | 客户端版本号 |
| plat | 0 | int | 平台标识 |
| showtype | 2 | int | 展示类型 |
| parentid | 0 | int | 父榜单ID |
| apiver | 6 | int | API 版本 |
| area_code | 1 | int | 地区码 |
| withsong | 0 | int | 是否附带歌曲（0=不附带） |
| with_res_tag | 0 | int | 资源标签 |

## 完整拼接URL示例
```
http://mobilecdnbj.kugou.com/api/v3/rank/list?version=9108&plat=0&showtype=2&parentid=0&apiver=6&area_code=1&withsong=0&with_res_tag=0
```

## 返回说明
返回酷狗所有官方排行榜，包含：榜单ID(`rankid`)、榜单名称、封面、更新时间、简介等。
前端用于渲染 **首页热门榜单模块**，通过返回的 `rankid` 调用下方**榜单详情接口**获取榜单内歌曲。

## 返回示例
```json
{
    "data": {
        "timestamp": 1776736364,
        "total": 57,
        "show_line": 2,
        "theme": {
            "classify_list": [],
            "bg_image": "",
            "font": {
                "nt": "",
                "st": "",
                "line": "",
                "bold_line": ""
            }
        },
        "info": [
            {
                "children": [],
                "base_img": "",
                "rankname": "TOP500",
                "new_cycle": 1800,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112175202472916.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260326/20260326182610525334.jpg",
                "table_plaque": "http://imge.kugou.com/mcommon/{size}/20240311/20240311161214589894.png",
                "update_frequency_type": 1,
                "play_times": 12350450,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241219/20241219164221229666.png",
                "is_city_rank": 0,
                "classify": 1,
                "update_video_url": "http://vmobile.bssdlbig.kugou.com/202604210950/cf7cb845ae2fb581d7aca8d6c3a1c5d8/005f800c53f20db1507df80ee683304f.mp4",
                "haschildren": 0,
                "intro": "数据来源：全曲库歌曲\r\n排序方式：按歌曲喜爱用户数的总量排序\r\n更新频率：每天",
                "album_cover_color": "#3f3d64",
                "share_bg": "http://imge.kugou.com/mcommon/{size}/20240505/20240505213952649412.png",
                "id": 2,
                "jump_url": "",
                "rank_id_publish_date": "2026-04-20 08:30:01",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240311/20240311161212168226.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019122517263545.jpg",
                "zone": "tx6_bj_kmr",
                "show_play_count": 1,
                "isvol": 1,
                "count_down": 1800,
                "issue": 110,
                "newvol": {
                    "rank_cid": 111957,
                    "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260326/20260326182610525334.jpg",
                    "issue": 111,
                    "rank_id_publish_date": "2026-04-21 08:30:00",
                    "extra": {
                        "resp": {
                            "scheduled_release_conf": {
                                "scheduled_release_time": "10:00:00",
                                "latest_rank_cid": 111957,
                                "latest_rank_cid_publish_date": "2026-04-21 08:30:00"
                            },
                            "five_year_total": 233,
                            "new_total": 13,
                            "enjoy_total": 0,
                            "recent_year_total": 191,
                            "follow_total": 0,
                            "all_total": 500,
                            "vip_total": 0,
                            "rank_tag": [
                                {
                                    "desc": "有13首上新",
                                    "type": 3
                                }
                            ]
                        }
                    },
                    "zone": "tx6_bj_kmr",
                    "album_cover_color": "#3f3d64"
                },
                "custom_type": 0,
                "rank_cid": 111876,
                "rankid": 8888,
                "update_frequency": "每天",
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241219/20241219164215715999.png",
                "show_play_button": 0,
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "jump_title": "",
                "is_timing": 1,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20241219/20241219164226731176.png",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "10:00:00",
                            "latest_rank_cid": 111957,
                            "latest_rank_cid_publish_date": "2026-04-21 08:30:00"
                        },
                        "five_year_total": 227,
                        "new_total": 5,
                        "enjoy_total": 0,
                        "recent_year_total": 187,
                        "follow_total": 0,
                        "all_total": 500,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有5首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "ranktype": 2,
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241219/20241219164209670219.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "国潮音乐榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20241120/20241120202656406136.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260410/20260410100302174903.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 58603,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241120/20241120202652582516.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "酷狗音乐结合平台特色，通过播放、传播、互动等维度，结合歌曲自身播放热度等综合评估推出的全新音乐榜单",
                "rank_cid": 111641,
                "share_bg": "",
                "id": 381,
                "jump_url": "https://h5.kugou.com/rank/v-25ff3dc2/index.html?no_header=1&isHideTitleBar=1",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20241120/20241120202714284821.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 17,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20241120/20241120202704171523.jpg",
                "update_frequency": "周五凌晨更新周榜",
                "rankid": 85897,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241120/20241120202648670370.jpg",
                "jump_title": "国潮音乐榜",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-17 03:00:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111641,
                            "latest_rank_cid_publish_date": "2026-04-17 03:00:02"
                        },
                        "five_year_total": 99,
                        "new_total": 6,
                        "enjoy_total": 0,
                        "recent_year_total": 46,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有6首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64533d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241120/20241120202644296668.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "视频号热歌酷狗榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20251125/20251125164849670633.jpg",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260326/20260326182610525334.jpg",
                "table_plaque": "",
                "update_frequency_type": 1,
                "play_times": 979443,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20251125/20251125164846303137.jpg",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：全曲库歌曲\r\n排序方式：按酷狗、视频号双平台热度排序\r\n更新频率：每天",
                "rank_cid": 111961,
                "share_bg": "",
                "id": 451,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20251223/20251223151349439653.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 111,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20251125/20251125164851345134.jpg",
                "update_frequency": "每天",
                "rankid": 100530,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20251202/20251202193639551001.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-21 09:00:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111961,
                            "latest_rank_cid_publish_date": "2026-04-21 09:00:01"
                        },
                        "five_year_total": 79,
                        "new_total": 7,
                        "enjoy_total": 0,
                        "recent_year_total": 61,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有7首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3f3d64",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20251202/20251202193636899095.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "民谣榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112185421213960.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260314/20260314134421229984.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 87236,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184723841271.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：民谣歌曲\r\n排序方式：民谣歌曲偏好用户中，按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111593,
                "share_bg": "",
                "id": 297,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201182112930264.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20210618/20210618141310314738.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 51341,
                "show_play_button": 1,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20210726/20210726153251881781.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111593,
                            "latest_rank_cid_publish_date": "2026-04-16 10:10:01"
                        },
                        "five_year_total": 56,
                        "new_total": 16,
                        "enjoy_total": 0,
                        "recent_year_total": 43,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有16首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64503d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184719475668.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "纯音乐榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220526/20220526183526162247.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20241017/20241017111019584956.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 79477,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185328497476.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：纯音乐歌曲\r\n排序方式：纯音乐歌曲偏好用户中，按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111595,
                "share_bg": "",
                "id": 335,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201182552282816.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 59900,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20220526/20220526183522710866.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111595,
                            "latest_rank_cid_publish_date": "2026-04-16 10:10:01"
                        },
                        "five_year_total": 79,
                        "new_total": 9,
                        "enjoy_total": 0,
                        "recent_year_total": 46,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有9首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d6445",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185324343605.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "电音榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112185502385779.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20250903/20250903012631524103.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 125261,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184633830950.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：电音歌曲\r\n排序方式：电音歌曲偏好用户中，按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111599,
                "share_bg": "",
                "id": 119,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201182051692599.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019121749428993.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 33160,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20181019/20181019121747524588.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111599,
                            "latest_rank_cid_publish_date": "2026-04-16 10:10:01"
                        },
                        "five_year_total": 37,
                        "new_total": 6,
                        "enjoy_total": 0,
                        "recent_year_total": 20,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有6首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#A1A7B3",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184628349205.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "网络热歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20240913/20240913193040778733.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260413/20260413162221509564.jpg",
                "table_plaque": "",
                "update_frequency_type": 1,
                "play_times": 976548,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195640406479.png",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：网络流行歌曲\r\n排序方式：根据播放量、收藏量综合计算热度排序\r\n更新频率：每天",
                "rank_cid": 111967,
                "share_bg": "http://imge.kugou.com/mcommon/{size}/20240813/20240813142031842096.png",
                "id": 377,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240813/20240813142027366777.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 111,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195646781330.png",
                "update_frequency": "每天",
                "rankid": 82831,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195633189482.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-21 09:09:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111967,
                            "latest_rank_cid_publish_date": "2026-04-21 09:09:00"
                        },
                        "five_year_total": 100,
                        "new_total": 6,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有6首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d644b",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195626644029.png"
            },
            {
                "children": [],
                "base_img": "http://imge.kugou.com/mcommon/20251110/20251110163839805863.png",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "东莞榜",
                "new_cycle": 0,
                "banner_9": "",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260404/20260404230411385493.jpg",
                "table_plaque": "",
                "update_frequency_type": 6,
                "play_times": 159746,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20250429/20250429191554606312.jpg",
                "is_city_rank": 1,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：城市用户偏好歌曲\r\n排序方式：按用户对歌曲喜爱和传播分数排序，取前50名\r\n更新频率：每周",
                "rank_cid": 111545,
                "share_bg": "",
                "id": 391,
                "jump_url": "https://activity.kugou.com/rank/v-8f1c3320/index.html?isHideTitleBar=1&city_id=87785",
                "share_logo": "",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20250429/20250429191558562097.jpg",
                "update_frequency": "每周四更新",
                "rankid": 87785,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20250429/20250429191549665857.jpg",
                "jump_title": "东莞榜",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 08:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111545,
                            "latest_rank_cid_publish_date": "2026-04-16 08:10:01"
                        },
                        "five_year_total": 17,
                        "new_total": 13,
                        "enjoy_total": 0,
                        "recent_year_total": 8,
                        "follow_total": 0,
                        "all_total": 50,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有13首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d5364",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20250429/20250429191544193127.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "rankname": "飙升榜",
                "new_cycle": 1800,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112175144811731.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260410/20260410111514514801.jpg",
                "table_plaque": "http://imge.kugou.com/mcommon/{size}/20240311/20240311161250324075.png",
                "update_frequency_type": 1,
                "play_times": 2103475,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241219/20241219193642821931.png",
                "is_city_rank": 0,
                "classify": 1,
                "update_video_url": "http://vmobile.bssdlbig.kugou.com/202604210950/cf7cb845ae2fb581d7aca8d6c3a1c5d8/005f800c53f20db1507df80ee683304f.mp4",
                "haschildren": 0,
                "intro": "数据来源：全曲库歌曲\r\n排序方式：按歌曲首次完整播放的涨幅排序\r\n更新频率：日榜每天更新；实时榜每小时更新",
                "album_cover_color": "#3d4f64",
                "share_bg": "http://imge.kugou.com/mcommon/{size}/20240505/20240505213932704436.png",
                "id": 1,
                "jump_url": "",
                "rank_id_publish_date": "2026-04-20 08:30:04",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240311/20240311161248641666.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20190214/20190214100333414437.jpg",
                "zone": "tx6_bj_kmr",
                "show_play_count": 1,
                "isvol": 1,
                "count_down": 1800,
                "issue": 110,
                "newvol": {
                    "rank_cid": 111959,
                    "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260419/20260419113042229584.jpg",
                    "issue": 111,
                    "rank_id_publish_date": "2026-04-21 08:30:05",
                    "extra": {
                        "resp": {
                            "scheduled_release_conf": {
                                "scheduled_release_time": "10:00:00",
                                "latest_rank_cid": 111959,
                                "latest_rank_cid_publish_date": "2026-04-21 08:30:05"
                            },
                            "five_year_total": 99,
                            "new_total": 62,
                            "enjoy_total": 0,
                            "recent_year_total": 98,
                            "follow_total": 0,
                            "all_total": 100,
                            "vip_total": 0,
                            "rank_tag": [
                                {
                                    "desc": "有62首上新",
                                    "type": 3
                                }
                            ]
                        }
                    },
                    "zone": "tx6_bj_kmr",
                    "album_cover_color": "#A1A7B3"
                },
                "custom_type": 0,
                "rank_cid": 111877,
                "rankid": 6666,
                "update_frequency": "每天",
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241219/20241219193635701220.png",
                "show_play_button": 0,
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "jump_title": "",
                "is_timing": 1,
                "img_cover": "",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "10:00:00",
                            "latest_rank_cid": 111959,
                            "latest_rank_cid_publish_date": "2026-04-21 08:30:05"
                        },
                        "five_year_total": 98,
                        "new_total": 72,
                        "enjoy_total": 0,
                        "recent_year_total": 97,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有72首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "ranktype": 2,
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241219/20241219193628550054.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "抖音热歌酷狗榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20250725/20250725182539486453.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260326/20260326182610525334.jpg",
                "table_plaque": "",
                "update_frequency_type": 3,
                "play_times": 1792274,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20250725/20250725182535424704.png",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：抖音热门歌曲\r\n排序方式：按照歌曲在酷狗的播放热度排序\r\n更新频率：每周一",
                "rank_cid": 111920,
                "share_bg": "",
                "id": 309,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240120/20240120135055507372.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20250725/20250725182736250567.png",
                "update_frequency": "周一",
                "rankid": 52144,
                "show_play_button": 1,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20250725/20250725182530380290.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 15:59:59",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111920,
                            "latest_rank_cid_publish_date": "2026-04-20 15:59:59"
                        },
                        "five_year_total": 27,
                        "new_total": 5,
                        "enjoy_total": 0,
                        "recent_year_total": 20,
                        "follow_total": 0,
                        "all_total": 31,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有5首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3f3d64",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20250725/20250725182524501565.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "摇滚榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220526/20220526175153586400.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20231122/20231122102202389639.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 146412,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184948886914.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：摇滚歌曲\r\n排序方式：摇滚歌曲偏好用户中，按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111588,
                "share_bg": "",
                "id": 329,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201182522193786.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 59896,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20220526/20220526175148858661.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:10:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111588,
                            "latest_rank_cid_publish_date": "2026-04-16 10:10:00"
                        },
                        "five_year_total": 5,
                        "new_total": 2,
                        "enjoy_total": 0,
                        "recent_year_total": 1,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有2首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#A1A7B3",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184944114279.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "DJ热歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112180428816873.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260322/20260322213256724282.jpg",
                "table_plaque": "",
                "update_frequency_type": 6,
                "play_times": 4471320,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241219/20241219194432797929.png",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：DJ类歌曲\r\n排序方式：按歌曲喜爱用户数的总量排序\r\n更新频率：每周四",
                "rank_cid": 111582,
                "share_bg": "",
                "id": 109,
                "jump_url": "",
                "share_logo": "",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019122335144078.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 24971,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241219/20241219194425213772.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 09:55:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111582,
                            "latest_rank_cid_publish_date": "2026-04-16 09:55:00"
                        },
                        "five_year_total": 97,
                        "new_total": 31,
                        "enjoy_total": 0,
                        "recent_year_total": 83,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有31首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64523d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241219/20241219194419154116.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "国乐榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20240508/20240508185110117696.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20190108/20190108183657297352.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 107420,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184540185530.png",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：国乐歌曲\r\n排序方式：按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111563,
                "share_bg": "",
                "id": 371,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240508/20240508184618291530.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四更新",
                "rankid": 80025,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20240508/20240508184601781750.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:34:18",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111563,
                            "latest_rank_cid_publish_date": "2026-04-16 10:34:18"
                        },
                        "recent_year_total": 0,
                        "all_total": 100,
                        "follow_total": 0,
                        "five_year_total": 17,
                        "new_total": 0,
                        "vip_total": 0,
                        "enjoy_total": 0
                    }
                },
                "album_cover_color": "#644b3d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184535924138.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "百万收藏榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20241028/20241028180214551357.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20200620/20200620103339135851.jpg",
                "table_plaque": "",
                "update_frequency_type": 1,
                "play_times": 2176572,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241219/20241219171054629387.png",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：全曲库歌曲，且喜爱用户数达到百万以上\r\n排序方式：按歌曲昨日新增喜爱用户数排序\r\n更新频率：每天",
                "rank_cid": 111968,
                "share_bg": "",
                "id": 379,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20241028/20241028180236126832.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 111,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20241219/20241219171100204264.png",
                "update_frequency": "",
                "rankid": 85432,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241219/20241219171047444807.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-21 09:10:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111968,
                            "latest_rank_cid_publish_date": "2026-04-21 09:10:00"
                        },
                        "five_year_total": 15,
                        "new_total": 1,
                        "enjoy_total": 0,
                        "recent_year_total": 0,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有1首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64503d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241219/20241219171042182683.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "快手热歌酷狗榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20250725/20250725183232975577.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260416/20260416144321238428.jpg",
                "table_plaque": "",
                "update_frequency_type": 1,
                "play_times": 285039,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20250725/20250725183225899271.png",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：快手热门歌曲\r\n排序方式：按照歌曲在酷狗的播放热度排序\r\n更新频率：每天",
                "rank_cid": 111892,
                "share_bg": "",
                "id": 311,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240120/20240120135123246050.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20250725/20250725183220279304.png",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 110,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "每天",
                "rankid": 52767,
                "show_play_button": 1,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20250725/20250725183212465337.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 09:50:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "10:00:00",
                            "latest_rank_cid": 111976,
                            "latest_rank_cid_publish_date": "2026-04-21 09:50:01"
                        },
                        "five_year_total": 70,
                        "new_total": 3,
                        "enjoy_total": 0,
                        "recent_year_total": 51,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有3首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d5c64",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20250725/20250725183206991263.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "新歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20240718/20240718102057550525.jpg",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260417/20260417095432696335.jpg",
                "table_plaque": "",
                "update_frequency_type": 1,
                "play_times": 246108,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20240718/20240718102052847101.jpg",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：全曲库歌曲\r\n排序方式：按近30天内新发行歌曲的听众喜爱程度排序\r\n更新频率：每天",
                "rank_cid": 111872,
                "share_bg": "",
                "id": 367,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240120/20240120135147371560.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 110,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "每日更新",
                "rankid": 74534,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241219/20241219200518856960.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 08:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "10:00:00",
                            "latest_rank_cid": 111952,
                            "latest_rank_cid_publish_date": "2026-04-21 08:10:02"
                        },
                        "five_year_total": 100,
                        "new_total": 19,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有19首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d6453",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241219/20241219200509300768.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "名品堂",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20241127/20241127175429856372.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20240428/20240428110704635631.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 740208,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195037386521.png",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "酷狗音乐平台评选出最具影响力的歌曲排行榜",
                "rank_cid": 102909,
                "share_bg": "",
                "id": 385,
                "jump_url": "https://h5.kugou.com/rank/v-670d7ad2/index.html?no_header=1&isHideTitleBar=1",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20241127/20241127175446550078.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 1,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195042834168.png",
                "update_frequency": "每年年底",
                "rankid": 84235,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195031629750.png",
                "jump_title": "名品堂",
                "is_timing": 0,
                "rank_id_publish_date": "2025-12-30 18:00:33",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 102909,
                            "latest_rank_cid_publish_date": "2025-12-30 18:00:33"
                        },
                        "five_year_total": 2,
                        "new_total": 19,
                        "enjoy_total": 0,
                        "recent_year_total": 0,
                        "follow_total": 0,
                        "all_total": 200,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有19首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#643d5d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195054422404.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "内地榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112175510473796.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260417/20260417095432696335.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 135504,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192156257611.png",
                "is_city_rank": 0,
                "classify": 2,
                "haschildren": 0,
                "intro": "数据来源：30天内发行的内地新歌\r\n排序方式：酷狗音乐的喜爱用户数和发行时间等综合评分排序取前100名\r\n更新频率：每周一至周五",
                "rank_cid": 111902,
                "share_bg": "",
                "id": 35,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201181301112318.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019122310609161.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 78,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192201402850.png",
                "update_frequency": "工作日",
                "rankid": 31308,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192151619051.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 10:10:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111902,
                            "latest_rank_cid_publish_date": "2026-04-20 10:10:02"
                        },
                        "five_year_total": 100,
                        "new_total": 22,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有22首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d6453",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192146592398.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "粤语金曲榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112182815519220.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20250925/20250925231951239621.jpg",
                "table_plaque": "",
                "update_frequency_type": 5,
                "play_times": 1124639,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241219/20241219200134192924.png",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：粤语歌曲\r\n排序方式：按歌曲完整播放日均量排序\r\n更新频率：每周三",
                "rank_cid": 111487,
                "share_bg": "",
                "id": 38,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153030141020.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019121613673415.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周三",
                "rankid": 33165,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241219/20241219200126629293.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-15 10:10:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111487,
                            "latest_rank_cid_publish_date": "2026-04-15 10:10:02"
                        },
                        "recent_year_total": 2,
                        "all_total": 100,
                        "follow_total": 0,
                        "five_year_total": 4,
                        "new_total": 0,
                        "vip_total": 0,
                        "enjoy_total": 0
                    }
                },
                "album_cover_color": "#64613d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241219/20241219200119140556.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "欧美榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112180200601680.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260418/20260418051111500600.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 45401,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192501998650.jpg",
                "is_city_rank": 0,
                "classify": 2,
                "haschildren": 0,
                "intro": "数据来源：30天内发行的欧美新歌\r\n排序方式：酷狗音乐的喜爱用户数和发行时间等综合评分排序取前100名\r\n更新频率：每周一至周五",
                "rank_cid": 111903,
                "share_bg": "",
                "id": 36,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201181455789502.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019122242395797.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 78,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "工作日",
                "rankid": 31310,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192458794157.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 10:10:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111903,
                            "latest_rank_cid_publish_date": "2026-04-20 10:10:02"
                        },
                        "five_year_total": 100,
                        "new_total": 64,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有64首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#503d64",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192454699571.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "伤感榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112182915645909.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260326/20260326182610525334.jpg",
                "table_plaque": "",
                "update_frequency_type": 5,
                "play_times": 338057,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195225391234.png",
                "is_city_rank": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "数据来源：伤感歌曲，包括抒情伤怀、孤单寂寞和失恋类型的歌曲\r\n排序方式：伤感歌曲偏好用户中，按歌曲日均喜爱用户数排序\r\n更新频率：每周三",
                "rank_cid": 111481,
                "share_bg": "",
                "id": 295,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153134109724.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20210618/20210618141117797248.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周三",
                "rankid": 51340,
                "show_play_button": 1,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195218676555.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-15 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111481,
                            "latest_rank_cid_publish_date": "2026-04-15 10:10:01"
                        },
                        "five_year_total": 75,
                        "new_total": 26,
                        "enjoy_total": 0,
                        "recent_year_total": 61,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有26首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3f3d64",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241219/20241219195213930623.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "韩国榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112180301782279.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260415/20260415150322995844.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 19512,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192543139821.jpg",
                "is_city_rank": 0,
                "classify": 2,
                "haschildren": 0,
                "intro": "数据来源：60天内发行的韩国乐坛新歌\r\n排序方式：酷狗音乐的喜爱用户数和发行时间等综合评分排序取前100名\r\n更新频率：每周一至周五",
                "rank_cid": 111897,
                "share_bg": "",
                "id": 67,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201181438821996.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019122200515578.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 78,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "工作日",
                "rankid": 31311,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192539728046.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 10:10:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111897,
                            "latest_rank_cid_publish_date": "2026-04-20 10:10:00"
                        },
                        "five_year_total": 100,
                        "new_total": 13,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有13首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#643d4a",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192536531946.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "日本榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112180343906494.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260417/20260417181630522993.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 9574,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192711120453.jpg",
                "is_city_rank": 0,
                "classify": 2,
                "haschildren": 0,
                "intro": "数据来源：90天内发行的日本乐坛新歌\r\n排序方式：酷狗音乐的喜爱用户数和发行时间等综合评分排序取前100名\r\n更新频率：每周一至周五",
                "rank_cid": 111905,
                "share_bg": "",
                "id": 69,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201181917132875.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019122124188716.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 78,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "工作日",
                "rankid": 31312,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192707926318.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 10:10:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111905,
                            "latest_rank_cid_publish_date": "2026-04-20 10:10:02"
                        },
                        "five_year_total": 100,
                        "new_total": 21,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有21首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d5864",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192703831514.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "香港地区榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112180038607846.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260413/20260413161041585067.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 22989,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192257395020.jpg",
                "is_city_rank": 0,
                "classify": 2,
                "haschildren": 0,
                "intro": "数据来源：90天内发行的香港地区新歌\r\n排序方式：酷狗音乐的喜爱用户数和发行时间等综合评分排序取前100名\r\n更新频率：每周一至周五",
                "rank_cid": 111901,
                "share_bg": "",
                "id": 39,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201181407810745.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019122021568840.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 78,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "工作日",
                "rankid": 31313,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192253592827.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 10:10:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111901,
                            "latest_rank_cid_publish_date": "2026-04-20 10:10:02"
                        },
                        "five_year_total": 100,
                        "new_total": 8,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有8首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#644c3d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192249298044.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "rankname": "腾讯音乐榜_由你榜&浪潮榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220117/20220117162947615029.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260401/20260401170230740732.jpg",
                "table_plaque": "",
                "update_frequency_type": 11,
                "play_times": 123010,
                "img_9": "",
                "ranktype": 0,
                "classify": 1,
                "haschildren": 0,
                "intro": "腾讯音乐榜是TME腾讯音乐集团推出的旨在反映华语乐坛最新歌曲热度的音乐榜单",
                "rank_cid": 0,
                "share_bg": "",
                "id": 195,
                "jump_url": "https://yobang.tencentmusic.com/enter.html?from=rank&platform=kg",
                "share_logo": "",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20180916/20180916215007684922.jpg",
                "show_play_count": 1,
                "isvol": 0,
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "zone": "",
                "custom_type": 5,
                "show_play_button": 0,
                "issue": 16,
                "update_frequency": "周日",
                "img_cover": "",
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20180916/20180916215004301124.jpg",
                "rankid": 33911,
                "jump_title": "腾讯音乐榜",
                "is_timing": 0,
                "count_down": 0,
                "rank_id_publish_date": "",
                "is_city_rank": 0,
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20181127/20181127105200682593.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "JOOX香港热歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20250609/20250609104830624427.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260409/20260409152943468402.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 78,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20250609/20250609104607996692.jpg",
                "is_city_rank": 0,
                "classify": 2,
                "haschildren": 0,
                "intro": "数据来源：JOOX平台\r\n排序方式：根据JOOX播放等指标进行排序\r\n更新频率：每周四",
                "rank_cid": 111613,
                "share_bg": "",
                "id": 251,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20250609/20250609104630858539.jpg",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20200320/20200320185608883318.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 42807,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20250609/20250609104602108475.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 15:31:41",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111613,
                            "latest_rank_cid_publish_date": "2026-04-16 15:31:41"
                        },
                        "five_year_total": 98,
                        "new_total": 13,
                        "enjoy_total": 0,
                        "recent_year_total": 98,
                        "follow_total": 0,
                        "all_total": 98,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有13首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#54643d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20250609/20250609104556453665.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "80后热歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112174930930724.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260312/20260312163031155291.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 226874,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185830898787.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "排序方式：按年龄段的喜爱热度高低排序\r\n更新频率：每天",
                "rank_cid": 111891,
                "share_bg": "",
                "id": 279,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122152922473818.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 110,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "每天",
                "rankid": 49225,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185826166886.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 09:50:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111891,
                            "latest_rank_cid_publish_date": "2026-04-20 09:50:00"
                        },
                        "five_year_total": 64,
                        "new_total": 3,
                        "enjoy_total": 0,
                        "recent_year_total": 54,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有3首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d4364",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185822886829.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "台湾地区榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112180058808380.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260409/20260409195551956933.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 3967,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192359341897.jpg",
                "is_city_rank": 0,
                "classify": 2,
                "haschildren": 0,
                "intro": "数据来源：90天内发行的台湾地区新歌\r\n排序方式：酷狗音乐的喜爱用户数和发行时间等综合评分排序取前100名\r\n更新频率：每周一至周五",
                "rank_cid": 111900,
                "share_bg": "",
                "id": 315,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201181345958236.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20241211/20241211192356855598.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 78,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "工作日",
                "rankid": 54848,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192352714822.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111900,
                            "latest_rank_cid_publish_date": "2026-04-20 10:10:01"
                        },
                        "five_year_total": 100,
                        "new_total": 21,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有21首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#A1A7B3",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211192349409526.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "R&B榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220526/20220526154506471406.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260226/20260226212302953357.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 111992,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184859784946.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：R&B歌曲\r\n排序方式：R&B歌曲偏好用户中，按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111590,
                "share_bg": "",
                "id": 327,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201182458313359.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 59895,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20220526/20220526154502223250.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:10:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111590,
                            "latest_rank_cid_publish_date": "2026-04-16 10:10:00"
                        },
                        "five_year_total": 75,
                        "new_total": 17,
                        "enjoy_total": 0,
                        "recent_year_total": 73,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有17首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#644e3d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184856929448.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "说唱先锋榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112185300288680.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20251219/20251219111752701899.jpg",
                "table_plaque": "",
                "update_frequency_type": 6,
                "play_times": 8060,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20240730/20240730155713301274.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：说唱歌曲\r\n排序方式：说唱歌曲偏好用户中，按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111562,
                "share_bg": "",
                "id": 265,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240120/20240120135236253443.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20211021/20211021121451321597.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 44412,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20240730/20240730164831103337.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 08:30:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111562,
                            "latest_rank_cid_publish_date": "2026-04-16 08:30:00"
                        },
                        "five_year_total": 100,
                        "new_total": 15,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有15首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#A1A7B3",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20240801/20240801174246809486.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "90后热歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112174949199742.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260326/20260326182610525334.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 379365,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185918447184.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "排序方式：按年龄段的喜爱热度高低排序\r\n更新频率：每天",
                "rank_cid": 111889,
                "share_bg": "",
                "id": 281,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122152959291198.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 110,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "每天",
                "rankid": 49223,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185914313564.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 09:50:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111889,
                            "latest_rank_cid_publish_date": "2026-04-20 09:50:00"
                        },
                        "recent_year_total": 24,
                        "all_total": 100,
                        "follow_total": 0,
                        "five_year_total": 34,
                        "new_total": 0,
                        "vip_total": 0,
                        "enjoy_total": 0
                    }
                },
                "album_cover_color": "#3f3d64",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185910253287.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "KKBOX风云榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112182509814250.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260319/20260319101420611881.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 1496,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20250605/20250605114549862189.jpg",
                "is_city_rank": 0,
                "classify": 2,
                "haschildren": 0,
                "intro": "数据来源：KKBOX平台\r\n排序方式：根据KKBOX播放等指标进行排序\r\n更新频率：每周五",
                "rank_cid": 111699,
                "share_bg": "",
                "id": 253,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153651574304.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20210310/20210310161810367993.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20250605/20250605114553675314.jpg",
                "update_frequency": "周五",
                "rankid": 42808,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20250605/20250605114546194695.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-17 14:42:06",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111699,
                            "latest_rank_cid_publish_date": "2026-04-17 14:42:06"
                        },
                        "five_year_total": 50,
                        "new_total": 13,
                        "enjoy_total": 0,
                        "recent_year_total": 50,
                        "follow_total": 0,
                        "all_total": 50,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有13首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64503d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20250605/20250605114541276767.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "00后热歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112175003333610.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260419/20260419113042229584.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 220797,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190002371409.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "排序方式：按年龄段的喜爱热度高低排序\r\n更新频率：每天",
                "rank_cid": 111977,
                "share_bg": "",
                "id": 283,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122152941935594.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 111,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "每天",
                "rankid": 49224,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185959657223.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-21 09:50:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111977,
                            "latest_rank_cid_publish_date": "2026-04-21 09:50:02"
                        },
                        "five_year_total": 36,
                        "new_total": 26,
                        "enjoy_total": 0,
                        "recent_year_total": 21,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有26首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#A1A7B3",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185955370846.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "ACG新歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112180755701754.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260407/20260407105043311970.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 12756,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184813165499.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：180天内发行的ACG新歌\r\n排序方式：按歌曲热度、歌手等级和发行时间综合评分排序\r\n更新频率：每周四",
                "rank_cid": 111592,
                "share_bg": "",
                "id": 123,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201182438720633.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20190911/20190911195359896034.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 33162,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20190911/20190911195358567855.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111592,
                            "latest_rank_cid_publish_date": "2026-04-16 10:10:01"
                        },
                        "five_year_total": 100,
                        "new_total": 4,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有4首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d5064",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211184809101184.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "会员热歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20230725/20230725144604584427.jpg",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20251212/20251212143010767309.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 200771,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190820337679.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "数据来源：酷狗会员歌曲\r\n排序方式：按会员中付费歌曲的喜爱人数和飙升幅度综合排名\r\n更新频率：每天",
                "rank_cid": 111965,
                "share_bg": "",
                "id": 215,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153200524979.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20190311/20190311103837451504.png",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 111,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周一",
                "rankid": 35811,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20190311/20190311103835919973.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-21 09:03:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111965,
                            "latest_rank_cid_publish_date": "2026-04-21 09:03:00"
                        },
                        "five_year_total": 34,
                        "new_total": 4,
                        "enjoy_total": 0,
                        "recent_year_total": 15,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有4首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d4964",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190815330214.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "欧美金曲榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112182840988260.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20250813/20250813073642531553.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 382182,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190356974014.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "数据来源：英语/西班牙语/葡萄牙语/法语/德语歌曲\r\n排序方式：按歌曲完整播放日均量排序\r\n更新频率：每周三",
                "rank_cid": 111480,
                "share_bg": "",
                "id": 193,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153057848861.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019121546998825.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周三",
                "rankid": 33166,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20181019/20181019121544655833.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-15 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111480,
                            "latest_rank_cid_publish_date": "2026-04-15 10:10:01"
                        },
                        "five_year_total": 13,
                        "new_total": 1,
                        "enjoy_total": 0,
                        "recent_year_total": 3,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有1首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#A1A7B3",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190352819248.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "影视金曲榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112182855975994.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260330/20260330212820411927.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 36502,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190502990969.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "数据来源：影视歌曲\r\n排序方式：影视歌曲偏好用户中，按歌曲日均喜爱用户数排序\r\n更新频率：每周三",
                "rank_cid": 111467,
                "share_bg": "",
                "id": 77,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153115710878.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019121704873377.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周三",
                "rankid": 33163,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20181019/20181019121701875027.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-15 09:30:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111467,
                            "latest_rank_cid_publish_date": "2026-04-15 09:30:00"
                        },
                        "five_year_total": 29,
                        "new_total": 7,
                        "enjoy_total": 0,
                        "recent_year_total": 19,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有7首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64523d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190457598263.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "爵士榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220526/20220526180332713906.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20190328/20190328114904504074.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 3783,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185043641681.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：爵士歌曲\r\n排序方式：按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111603,
                "share_bg": "",
                "id": 331,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122152410537626.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 59897,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20220526/20220526180328421377.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:10:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111603,
                            "latest_rank_cid_publish_date": "2026-04-16 10:10:02"
                        },
                        "five_year_total": 46,
                        "new_total": 9,
                        "enjoy_total": 0,
                        "recent_year_total": 31,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有9首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#453d64",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185038580940.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "乡村音乐榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220526/20220526181211477452.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260206/20260206025902620494.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 8372,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185128483801.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：乡村音乐歌曲\r\n排序方式：按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111589,
                "share_bg": "",
                "id": 333,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201182538748209.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 59898,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20220526/20220526181207153447.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:10:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111589,
                            "latest_rank_cid_publish_date": "2026-04-16 10:10:00"
                        },
                        "five_year_total": 55,
                        "new_total": 12,
                        "enjoy_total": 0,
                        "recent_year_total": 35,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有12首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64643d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185123607801.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "儿歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20221227/20221227161137554607.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20210312/20210312201117210481.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 22253,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191512524582.png",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "排序方式：按儿童歌曲日均喜爱用户数排序\r\n更新频率：每周二",
                "rank_cid": 111397,
                "share_bg": "",
                "id": 347,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201172122956625.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周二",
                "rankid": 65234,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191506693630.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-14 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111397,
                            "latest_rank_cid_publish_date": "2026-04-14 10:10:01"
                        },
                        "five_year_total": 48,
                        "new_total": 1,
                        "enjoy_total": 0,
                        "recent_year_total": 7,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有1首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#644f3d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191500485663.png"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "闽南语榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220607/20220607152041564464.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20240517/20240517172523501584.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 119720,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191339480162.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "数据来源：闽南语歌曲\r\n排序方式：按歌曲日均喜爱用户数排序\r\n更新频率：每周二",
                "rank_cid": 111402,
                "share_bg": "",
                "id": 339,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240120/20240120134634315770.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周二",
                "rankid": 60170,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191336754266.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-14 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111402,
                            "latest_rank_cid_publish_date": "2026-04-14 10:10:01"
                        },
                        "five_year_total": 28,
                        "new_total": 1,
                        "enjoy_total": 0,
                        "recent_year_total": 8,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有1首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d5064",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191332657103.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "综艺新歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112183043219580.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260409/20260409164321325736.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 5155,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191126521980.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "数据来源：60天内发行的综艺新歌\r\n排序方式：按歌曲热度、歌手等级和发行时间综合评分排序\r\n更新频率：每周三",
                "rank_cid": 111454,
                "share_bg": "",
                "id": 275,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153259314881.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20201109/20201109170517558959.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周三",
                "rankid": 46910,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20201109/20201109170516777658.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-15 08:30:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111454,
                            "latest_rank_cid_publish_date": "2026-04-15 08:30:00"
                        },
                        "five_year_total": 100,
                        "new_total": 24,
                        "enjoy_total": 0,
                        "recent_year_total": 100,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有24首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d6453",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191122925263.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "酷狗音乐人原创榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220117/20220117163024782170.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20250510/20250510215611825024.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 5834,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191235865169.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "酷狗音乐人原创作品官方榜单，以推荐优秀原创作品为目的，按歌曲热度和收藏转化等维度排序，每天更新。",
                "rank_cid": 111896,
                "share_bg": "",
                "id": 167,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240120/20240120134710377946.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20210125/20210125161120160525.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 110,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "每天",
                "rankid": 30972,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20210125/20210125161119250170.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 10:10:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111896,
                            "latest_rank_cid_publish_date": "2026-04-20 10:10:00"
                        },
                        "recent_year_total": 9,
                        "all_total": 100,
                        "follow_total": 0,
                        "five_year_total": 100,
                        "new_total": 0,
                        "vip_total": 0,
                        "enjoy_total": 0
                    }
                },
                "album_cover_color": "#644b3d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211191231362267.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "酷狗识曲榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20241011/20241011164248791003.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260325/20260325182011489956.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 262,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190937198659.jpg",
                "is_city_rank": 0,
                "classify": 3,
                "haschildren": 0,
                "intro": "数据来源：酷狗音乐听歌识曲\r\n排序方式：按近一周识曲用户数排序\r\n更新频率：每周一至周五",
                "rank_cid": 111907,
                "share_bg": "",
                "id": 227,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20241011/20241011164304140685.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20190808/20190808200005885980.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 78,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190941589295.jpg",
                "update_frequency": "工作日",
                "rankid": 37361,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190933216251.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 10:40:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111907,
                            "latest_rank_cid_publish_date": "2026-04-20 10:40:01"
                        },
                        "five_year_total": 74,
                        "new_total": 13,
                        "enjoy_total": 0,
                        "recent_year_total": 63,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有13首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64493d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211190930749712.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "古典榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220526/20220526184422104700.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20171023/20171023181015675033.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 3529,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185549215849.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：古典歌曲\r\n排序方式：按歌曲日均喜爱用户数排序\r\n更新频率：每周四",
                "rank_cid": 111600,
                "share_bg": "",
                "id": 337,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240201/20240201182610660428.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周四",
                "rankid": 59899,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20220526/20220526184417553813.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-16 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111600,
                            "latest_rank_cid_publish_date": "2026-04-16 10:10:01"
                        },
                        "five_year_total": 21,
                        "new_total": 1,
                        "enjoy_total": 0,
                        "recent_year_total": 0,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有1首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64583d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241211/20241211185545620318.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "美国BillBoard榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112181537635196.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20251015/20251015005111668122.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 15964,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241129/20241129191455181782.jpg",
                "is_city_rank": 0,
                "classify": 4,
                "haschildren": 0,
                "intro": "数据来源：美国Billboard Top100\r\n排序方式：根据歌曲在美国的实体销量、电台播放量、流媒体下载量等指标进行排序\r\n更新频率：每周三",
                "rank_cid": 111492,
                "share_bg": "",
                "id": 10,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153349910519.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019121340103598.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周三",
                "rankid": 4681,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20181019/20181019121339813327.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-15 11:38:55",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111492,
                            "latest_rank_cid_publish_date": "2026-04-15 11:38:55"
                        },
                        "five_year_total": 89,
                        "new_total": 7,
                        "enjoy_total": 0,
                        "recent_year_total": 77,
                        "follow_total": 0,
                        "all_total": 94,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有7首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#643d45",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241129/20241129191451959672.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "粤剧榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20260317/20260317180343148037.jpg",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20201104/20201104101911516366.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 1809,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20260318/20260318165500762988.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：粤剧音乐\r\n排序方式：按歌曲播放量排序\r\n更新频率：每周二",
                "rank_cid": 111963,
                "share_bg": "http://imge.kugou.com/mcommon/{size}/20260317/20260317180347469987.png",
                "id": 457,
                "jump_url": "",
                "share_logo": "",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 6,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20260318/20260318165506734718.jpg",
                "update_frequency": "每周二更新",
                "rankid": 108332,
                "show_play_button": 0,
                "banner7url": "",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-21 09:00:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111963,
                            "latest_rank_cid_publish_date": "2026-04-21 09:00:02"
                        },
                        "five_year_total": 2,
                        "new_total": 1,
                        "enjoy_total": 0,
                        "recent_year_total": 0,
                        "follow_total": 0,
                        "all_total": 50,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有1首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#643d49",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20260318/20260318165457262501.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "Beatport电子舞曲榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112181554865370.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260312/20260312191342834975.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 5295,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241129/20241129191257443346.jpg",
                "is_city_rank": 0,
                "classify": 4,
                "haschildren": 0,
                "intro": "数据来源：Beatport音乐网站\r\n排序方式：根据Beatport网站上的播放次数计算排序\r\n更新频率：每周三",
                "rank_cid": 111502,
                "share_bg": "",
                "id": 153,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153409506644.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20170223/20170223182819501244.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周三",
                "rankid": 25028,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20170223/20170223182818350949.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-15 15:55:34",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111502,
                            "latest_rank_cid_publish_date": "2026-04-15 15:55:34"
                        },
                        "five_year_total": 96,
                        "new_total": 25,
                        "enjoy_total": 0,
                        "recent_year_total": 95,
                        "follow_total": 0,
                        "all_total": 96,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有25首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#A1A7B3",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241129/20241129191254713903.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "京剧榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20260317/20260317181439866404.jpg",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20250101/20250101162616187607.jpg",
                "table_plaque": "",
                "update_frequency_type": 4,
                "play_times": 857,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20260318/20260318165624453523.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：京剧音乐\r\n排序方式：按歌曲播放量排序\r\n更新频率：每周二",
                "rank_cid": 111964,
                "share_bg": "http://imge.kugou.com/mcommon/{size}/20260317/20260317181444153374.png",
                "id": 459,
                "jump_url": "",
                "share_logo": "",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 6,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20260318/20260318165630238963.jpg",
                "update_frequency": "每周二更新",
                "rankid": 108333,
                "show_play_button": 0,
                "banner7url": "",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-21 09:00:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111964,
                            "latest_rank_cid_publish_date": "2026-04-21 09:00:02"
                        },
                        "five_year_total": 9,
                        "new_total": 7,
                        "enjoy_total": 0,
                        "recent_year_total": 1,
                        "follow_total": 0,
                        "all_total": 50,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有7首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#645b3d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20260318/20260318165621528435.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "英国单曲榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112181644889766.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20250622/20250622203821678018.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 4129,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241129/20241129184846960119.jpg",
                "is_city_rank": 0,
                "classify": 4,
                "haschildren": 0,
                "intro": "数据来源：英国Single Chart Top 40\r\n排序方式：根据歌曲在英国的一周销量进行排序\r\n更新频率：每周一",
                "rank_cid": 111918,
                "share_bg": "",
                "id": 12,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153446547443.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019121317188050.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周一",
                "rankid": 4680,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20181019/20181019121316839345.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 15:21:58",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111918,
                            "latest_rank_cid_publish_date": "2026-04-20 15:21:58"
                        },
                        "five_year_total": 35,
                        "new_total": 4,
                        "enjoy_total": 0,
                        "recent_year_total": 31,
                        "follow_total": 0,
                        "all_total": 40,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有4首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#A1A7B3",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241129/20241129184843867507.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "南音榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20260317/20260317181641758127.jpg",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20220130/20220130075535803151.jpg",
                "table_plaque": "",
                "update_frequency_type": 4,
                "play_times": 336,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20260318/20260318165735622097.jpg",
                "is_city_rank": 0,
                "classify": 5,
                "haschildren": 0,
                "intro": "数据来源：南音音乐\r\n排序方式：按歌曲播放量排序\r\n更新频率：每周二",
                "rank_cid": 111962,
                "share_bg": "http://imge.kugou.com/mcommon/{size}/20260317/20260317181645988209.png",
                "id": 461,
                "jump_url": "",
                "share_logo": "",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 6,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "http://imge.kugou.com/mcommon/{size}/20260318/20260318165740858587.jpg",
                "update_frequency": "每周二更新",
                "rankid": 108335,
                "show_play_button": 0,
                "banner7url": "",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-21 09:00:02",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111962,
                            "latest_rank_cid_publish_date": "2026-04-21 09:00:02"
                        },
                        "five_year_total": 48,
                        "new_total": 1,
                        "enjoy_total": 0,
                        "recent_year_total": 3,
                        "follow_total": 0,
                        "all_total": 50,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有1首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#46643d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20260318/20260318165732662096.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "韩国Melon音乐榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112181946586976.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260331/20260331092442228225.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 11789,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241129/20241129185011109120.jpg",
                "is_city_rank": 0,
                "classify": 4,
                "haschildren": 0,
                "intro": "数据来源：韩国Melon\r\n排序方式：根据Melon的销售、下载、播放等指标进行排序\r\n更新频率：每周一",
                "rank_cid": 111923,
                "share_bg": "",
                "id": 9,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153503316149.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019121225649566.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周一",
                "rankid": 38623,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20191021/20191021201705225728.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-20 16:34:10",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111923,
                            "latest_rank_cid_publish_date": "2026-04-20 16:34:10"
                        },
                        "five_year_total": 88,
                        "new_total": 3,
                        "enjoy_total": 0,
                        "recent_year_total": 48,
                        "follow_total": 0,
                        "all_total": 98,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有3首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64523d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241129/20241129185007675569.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "日本公信榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112182321514349.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260304/20260304194210412673.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 540,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241129/20241129190756504964.jpg",
                "is_city_rank": 0,
                "classify": 4,
                "haschildren": 0,
                "intro": "数据来源：日本Oricon Top20\r\n排序方式：根据日本实体CD销量进行排序\r\n更新频率：每周五",
                "rank_cid": 111691,
                "share_bg": "",
                "id": 8,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153614332486.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20181019/20181019121251431378.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 16,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周五",
                "rankid": 4673,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20181019/20181019121248478803.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-17 11:52:24",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111691,
                            "latest_rank_cid_publish_date": "2026-04-17 11:52:24"
                        },
                        "five_year_total": 19,
                        "new_total": 5,
                        "enjoy_total": 0,
                        "recent_year_total": 17,
                        "follow_total": 0,
                        "all_total": 20,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有5首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#3d4264",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241129/20241129190753306040.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "日本SS榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112182338294233.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260313/20260313144103708211.jpg",
                "table_plaque": "",
                "update_frequency_type": 8,
                "play_times": 37,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241129/20241129190927368295.jpg",
                "is_city_rank": 0,
                "classify": 4,
                "haschildren": 0,
                "intro": "数据来源：日本音乐频道 SPACE SHOWER TV\r\n排序方式：根据SPACE SHOWER频道上的播放次数计算排序\r\n更新频率：每周六",
                "rank_cid": 111721,
                "share_bg": "",
                "id": 273,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153629379830.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20201028/20201028152647239085.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 14,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "每周六",
                "rankid": 46868,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20201028/20201028152646615355.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-18 00:44:25",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "11:00:00",
                            "latest_rank_cid": 111721,
                            "latest_rank_cid_publish_date": "2026-04-18 00:44:25"
                        },
                        "five_year_total": 49,
                        "new_total": 17,
                        "enjoy_total": 0,
                        "recent_year_total": 49,
                        "follow_total": 0,
                        "all_total": 49,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有17首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#56643d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241129/20241129190920828981.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "小语种热歌榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220112/20220112182207909276.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20250903/20250903012631524103.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 55825,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241129/20241129184739889098.jpg",
                "is_city_rank": 0,
                "classify": 4,
                "haschildren": 0,
                "intro": "数据来源：“法语+德语+俄语+意大利语+西班牙语+葡萄牙语+瑞典语+拉丁语+印度语+小语种”语言下歌曲\r\n排序方式：按歌曲日均喜爱用户数排序\r\n更新频率：每周二",
                "rank_cid": 111403,
                "share_bg": "",
                "id": 217,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153557704779.png",
                "bannerurl": "http://imge.kugou.com/mcommonbanner/{size}/20190403/20190403162620781596.jpg",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周二",
                "rankid": 36107,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20240703/20240703151822858722.jpg",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-14 10:10:01",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111403,
                            "latest_rank_cid_publish_date": "2026-04-14 10:10:01"
                        },
                        "five_year_total": 45,
                        "new_total": 4,
                        "enjoy_total": 0,
                        "recent_year_total": 18,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有4首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#A1A7B3",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241129/20241129184735526204.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "越南语榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220607/20220607154647691236.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20250708/20250708144301413257.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 11658,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241129/20241129184930758096.jpg",
                "is_city_rank": 0,
                "classify": 4,
                "haschildren": 0,
                "intro": "数据来源：越南语歌曲\r\n排序方式：按歌曲日均喜爱用户数排序\r\n更新频率：每周二",
                "rank_cid": 111389,
                "share_bg": "",
                "id": 341,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153715826267.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周二",
                "rankid": 60171,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20220607/20220607160924294480.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-14 10:10:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111389,
                            "latest_rank_cid_publish_date": "2026-04-14 10:10:00"
                        },
                        "five_year_total": 81,
                        "new_total": 4,
                        "enjoy_total": 0,
                        "recent_year_total": 17,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有4首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#43643d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241129/20241129184925598181.jpg"
            },
            {
                "children": [],
                "base_img": "",
                "video_ending": "http://imge.kugou.com/mcommon/{size}/20240313/20240313142811662716.jpg",
                "rankname": "泰语榜",
                "new_cycle": 0,
                "banner_9": "http://imge.kugou.com/mcommon/{size}/20220607/20220607160847495424.png",
                "album_img_9": "http://imge.kugou.com/stdmusic/{size}/20260121/20260121010520341066.jpg",
                "table_plaque": "",
                "update_frequency_type": 0,
                "play_times": 9652,
                "img_9": "http://imge.kugou.com/mcommon/{size}/20241129/20241129191041354598.jpg",
                "is_city_rank": 0,
                "classify": 4,
                "haschildren": 0,
                "intro": "数据来源：泰语歌曲\r\n排序方式：按歌曲日均喜爱用户数排序\r\n更新频率：每周二",
                "rank_cid": 111390,
                "share_bg": "",
                "id": 343,
                "jump_url": "",
                "share_logo": "http://imge.kugou.com/mcommon/{size}/20240122/20240122153732185154.png",
                "bannerurl": "",
                "show_play_count": 1,
                "isvol": 1,
                "zone": "tx6_bj_kmr",
                "ranktype": 1,
                "issue": 15,
                "custom_type": 0,
                "count_down": 0,
                "img_cover": "",
                "update_frequency": "周二",
                "rankid": 60172,
                "show_play_button": 0,
                "banner7url": "http://imge.kugou.com/mcommon/{size}/20220607/20220607160843339942.png",
                "jump_title": "",
                "is_timing": 0,
                "rank_id_publish_date": "2026-04-14 10:10:00",
                "extra": {
                    "resp": {
                        "scheduled_release_conf": {
                            "scheduled_release_time": "00:00:00",
                            "latest_rank_cid": 111390,
                            "latest_rank_cid_publish_date": "2026-04-14 10:10:00"
                        },
                        "five_year_total": 100,
                        "new_total": 2,
                        "enjoy_total": 0,
                        "recent_year_total": 45,
                        "follow_total": 0,
                        "all_total": 100,
                        "vip_total": 0,
                        "rank_tag": [
                            {
                                "desc": "有2首上新",
                                "type": 3
                            }
                        ]
                    }
                },
                "album_cover_color": "#64503d",
                "imgurl": "http://imge.kugou.com/mcommon/{size}/20241129/20241129191037702382.jpg"
            }
        ]
    },
    "errcode": 0,
    "status": 1,
    "error": ""
}
```

---

# 2. 推荐歌单接口
## 接口信息
- 接口名称：酷狗歌单推荐 / 歌单搜索通用接口
- LX 音源方法：`getRecommendSongList()`
- 接口地址：
```
http://mobilecdn.kugou.com/api/v3/search/special
```
- 请求方式：`GET`

## 请求参数
| 参数名 | 参数值 | 类型 | 说明 |
|--------|--------|------|------|
| format | json | string | 返回数据格式 |
| keyword | 热门 | string | 搜索关键词，脚本默认传`热门`实现首页推荐 |
| page | 1 | int | 当前页码 |
| pagesize | 20 | int | 每页歌单数量 |
| showtype | 1 | int | 歌单展示类型 |

## 完整拼接URL示例
```
http://mobilecdn.kugou.com/api/v3/search/special?format=json&keyword=热门&page=1&pagesize=20&showtype=1
```

## 返回说明
返回大量官方精选歌单，包含歌单ID、歌单标题、封面图、播放量、歌曲总数、简介。
对应洛雪音乐首页 **歌单推荐板块**。


## 返回示例

```json
{
    "status": 1,
    "errcode": 0,
    "data": {
        "timestamp": 1776738463,
        "total": 480,
        "info": [
            {
                "specialid": 3102174,
                "playcount": 852713628,
                "songcount": 111,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "华语杂货铺",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "26年无限循环|抖音热门情歌（持续更新）",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20200923/20200923144713541841.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1085322503_53_0",
                "publishtime": "2020-09-23 10:17:17",
                "intro": "",
                "suid": 1085322503
            },
            {
                "specialid": 589483,
                "playcount": 131896923,
                "songcount": 32,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "儿歌小编-西瓜",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "抖音热门儿歌｜社交小达人养成，赢在潮流起跑线",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20260318/20260318171001291859.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1161594453_70_0",
                "publishtime": "2019-01-18 16:33:22",
                "intro": "",
                "suid": 1161594453
            },
            {
                "specialid": 9260420,
                "playcount": 25593734,
                "songcount": 394,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "梗八卦",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "抖音热门DJ：谁开车不听DJ呀",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20260116/20260116204156899021.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_2132041437_3_0",
                "publishtime": "2026-01-16 20:42:08",
                "intro": "",
                "suid": 2132041437
            },
            {
                "specialid": 7844451,
                "playcount": 10467186,
                "songcount": 446,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "酷乐推荐",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "抖音热门BGM畅听｜爆款视频的流量密码",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20260324/20260324113948123585.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_2132029040_293_0",
                "publishtime": "2024-08-02 17:00:04",
                "intro": "",
                "suid": 2132029040
            },
            {
                "specialid": 589982,
                "playcount": 14033135,
                "songcount": 94,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "君笑红尘",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 4,
                    "iden": 0,
                    "trans_flag": 1
                },
                "specialname": "热门韩语歌曲，挑动你的听觉神经",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20190619/20190619201508786656.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_509005823_32_0",
                "publishtime": "2019-01-19 14:43:10",
                "intro": "",
                "suid": 509005823
            },
            {
                "specialid": 678511,
                "playcount": 203999948,
                "songcount": 64,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "儿歌小编-西瓜",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "iden": 0,
                    "trans_flag": 1
                },
                "specialname": "0-6岁益智儿歌：热门早教儿歌，陪伴宝贝快乐启蒙",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20260318/20260318164503980702.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1161594453_129_0",
                "publishtime": "2019-05-07 14:21:16",
                "intro": "",
                "suid": 1161594453
            },
            {
                "specialid": 585374,
                "playcount": 457943900,
                "songcount": 135,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "儿歌小编-西瓜",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "【热门儿歌】益智又有趣，陪伴宝宝启蒙时光",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20260318/20260318154755200454.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1161594453_55_0",
                "publishtime": "2019-01-09 11:29:59",
                "intro": "",
                "suid": 1161594453
            },
            {
                "specialid": 2365291,
                "playcount": 268088165,
                "songcount": 278,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "儿歌小编-西瓜",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "iden": 0,
                    "trans_flag": 1
                },
                "specialname": "热门早教儿歌｜童声小太阳，陪伴宝贝快乐时光",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20260318/20260318161901269558.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1161594453_198_0",
                "publishtime": "2020-04-15 17:14:04",
                "intro": "",
                "suid": 1161594453
            },
            {
                "specialid": 7616603,
                "playcount": 6422819,
                "songcount": 26,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "殇",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "抖音热门DJ舞曲：跟着音乐摇起来",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20240509/20240509135821114792.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_509005687_35_0",
                "publishtime": "2024-05-09 13:59:56",
                "intro": "",
                "suid": 509005687
            },
            {
                "specialid": 6590557,
                "playcount": 1205663,
                "songcount": 28,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "伤心勒",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "iden": 0,
                    "trans_flag": 1
                },
                "specialname": "精选热门纯音：带上耳机安静聆听",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20230318/20230318145301351636.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_509004246_39_0",
                "publishtime": "2023-03-18 14:53:15",
                "intro": "",
                "suid": 509004246
            },
            {
                "specialid": 8306001,
                "playcount": 13030842,
                "songcount": 155,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "苍狼啸月",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "2026抖音流行热门DJ·持续更新",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20250822/20250822172510548122.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_509005944_40_0",
                "publishtime": "2025-02-07 09:54:52",
                "intro": "",
                "suid": 509005944
            },
            {
                "specialid": 8312976,
                "playcount": 1183644,
                "songcount": 37,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "国风小编-千金酷小姐",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "iden": 64,
                    "trans_flag": 1
                },
                "specialname": "热门动漫OST | 解锁国漫崛起新篇章",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20250210/20250210145200501592.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1106406311_300_0",
                "publishtime": "2025-02-10 14:12:25",
                "intro": "",
                "suid": 1106406311
            },
            {
                "specialid": 3391494,
                "playcount": 534368037,
                "songcount": 455,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "创世ぐ虎魔",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "iden": 0,
                    "trans_flag": 1
                },
                "specialname": "抖音热门歌曲盘点【最新最in】",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20210511/20210511141906857842.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_509004910_35_0",
                "publishtime": "2020-12-24 11:13:59",
                "intro": "",
                "suid": 509004910
            },
            {
                "specialid": 7587703,
                "playcount": 1981673,
                "songcount": 600,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "酷狗音乐官方歌单",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "is_mutual": 1,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "《歌手》历届热门选曲合集",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20240429/20240429101934780518.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1002717860_316_0",
                "publishtime": "2024-04-29 10:21:32",
                "intro": "",
                "suid": 1002717860
            },
            {
                "specialid": 7755282,
                "playcount": 32816880,
                "songcount": 81,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "华语杂货铺",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "2024上半年热门DJ歌曲盘点",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20240715/20240715162536992922.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1085322503_107_0",
                "publishtime": "2024-06-28 16:41:56",
                "intro": "",
                "suid": 1085322503
            },
            {
                "specialid": 8176393,
                "playcount": 1173897,
                "songcount": 89,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "华语杂货铺",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "火遍全网 | 超流行的热门粤语歌曲合集",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20241213/20241213231306346444.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1085322503_225_0",
                "publishtime": "2024-12-11 15:47:17",
                "intro": "",
                "suid": 1085322503
            },
            {
                "specialid": 7378851,
                "playcount": 15173045,
                "songcount": 19,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "小花",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "热门华语DJ丨派对模式现在开启",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20240201/20240201153505716053.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_509005558_38_0",
                "publishtime": "2024-02-01 15:28:12",
                "intro": "",
                "suid": 509005558
            },
            {
                "specialid": 7767597,
                "playcount": 24936366,
                "songcount": 460,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "天忆",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "trans_flag": 1,
                    "iden": 0
                },
                "specialname": "【2024】百首热门抖曲免费畅听",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20241120/20241120141436989423.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_509004799_34_0",
                "publishtime": "2024-07-03 17:59:02",
                "intro": "",
                "suid": 509004799
            },
            {
                "specialid": 120886,
                "playcount": 8502294,
                "songcount": 84,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "默雨小星",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "iden": 0,
                    "trans_flag": 1
                },
                "specialname": "BIGBANG热门歌曲大合集",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20190819/20190819105354917259.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_509005153_30_0",
                "publishtime": "2016-12-07 15:04:06",
                "intro": "",
                "suid": 509005153
            },
            {
                "specialid": 8211009,
                "playcount": 34243069,
                "songcount": 51,
                "isperiodical": 0,
                "singername": "",
                "slid": 0,
                "verified": 0,
                "nickname": "酷狗音乐官方歌单",
                "contain": "",
                "collectcount": 0,
                "trans_param": {
                    "special_tag": 0,
                    "iden": 0,
                    "trans_flag": 1
                },
                "specialname": "2024年度热门DJ盘点",
                "imgurl": "http://imge.kugou.com/soft/collection/{size}/20241225/20241225150229468195.jpg",
                "nper": 0,
                "iscustom": 0,
                "gid": "collection_3_1002717860_456_0",
                "publishtime": "2024-12-21 16:19:40",
                "intro": "",
                "suid": 1002717860
            }
        ]
    },
    "error": ""
}
```

## 

---

# 3. 推荐歌曲接口
## 接口信息
- 接口名称：酷狗综合歌曲搜索（音源内用作首页推荐歌曲）
- LX 音源方法：`getRecommendSongs()`
- 接口地址：
```
https://songsearch.kugou.com/song_search_v2
```
- 请求方式：`GET`

## 请求参数
| 参数名 | 参数值 | 类型 | 说明 |
|--------|--------|------|------|
| keyword | 热门歌曲 | string | 搜索关键词，脚本内置默认词实现推荐 |
| page | 1 | int | 页码 |
| pagesize | 20 | int | 单页歌曲数量 |
| userid | 0 | int | 用户ID，匿名访问填0 |
| clientver | 空 | string | 客户端版本 |
| platform | WebFilter | string | 平台过滤标识 |
| filter | 2 | int | 音质/版权过滤 |
| iscorrection | 1 | int | 关键词纠错开启 |
| privilege_filter | 0 | int | 特权歌曲过滤 |
| area_code | 1 | int | 地区编码 |

## 完整拼接URL示例
```
https://songsearch.kugou.com/song_search_v2?keyword=热门歌曲&page=1&pagesize=20&userid=0&clientver=&platform=WebFilter&filter=2&iscorrection=1&privilege_filter=0&area_code=1
```

## 返回说明
返回海量热门流行歌曲，包含歌曲ID、歌名、歌手、专辑、时长、封面。
对应洛雪音乐首页 **个性化推荐歌曲流**。

## 返回示例

```json
{"error_msg":"","data":{"correctiontip":"","pagesize":20,"page":1,"correctiontype":0,"correctionrelate":"","total":480,"lists":[{"SQFileHash":"BB5B842622AF6FED0FD2419FD6E75F3F","PublishTime":"","Audioid":22399633,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"陈粒","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":32219691,"AlbumAux":"","HQDuration":297,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20200620\/20200620103339135851.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58720256,"musicpack_advance":0,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"dfc11ffffff3fe475","attr0":2134893685,"attr1":2015625215},"pay_block_tpl":1,"hash_multitrack":"1FDE2B1A649FBA795B6B70ADC233E1C5","cid":5793787,"ogg_128_filesize":3409405,"ogg_320_hash":"7758D089F0C7FE1E85A0952206932F3F","ipmap":{"attr0":274911461504},"hash_offset":{"clip_hash":"CC3C53E186495E44552166D6CEFB59A4","start_byte":0,"end_ms":60000,"end_byte":960115,"file_type":0,"start_ms":0,"offset_hash":"79D89DF268C7A6AABBE6A15C2B38A4D3"},"ogg_128_hash":"50FF71DF026D178266C888A338A2C42E","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20200620\/20200620103339135851.jpg","ogg_320_filesize":11822917},"UploaderContent":"","FileSize":4756985,"IsOriginal":1,"FileHash":"AFEA9FFE5D7F0EF0874119A363820D33","FoldType":0,"Grp":[],"ID":"39693879","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":8,"AlbumID":"1749208","AlbumName":"小梦大半","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"40E7ACED0F692E8CB4896FE25F8365B3","id":"584130"}],"OtherName":"","SongName":"小半","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":297,"HQFileSize":11891531,"MixSongID":"39693879","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":297,"ResBitrate":3456,"HiFiQuality":3,"ResFileHash":"0F19F364246317A0822DD46E6E100647","SingerId":[176282],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":22399633,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"陈粒","ip_id":0,"id":176282}],"mvTotal":0,"MvHash":"40E7ACED0F692E8CB4896FE25F8365B3","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":866,"RankId":8888,"PublishDate":"2016-07-26","HQFileHash":"E1FB163AD061EF4843E4D6A45A5F2495","TopicUrl":"","TagDetails":[{"content":"TOP500 第10名","rankid":8888,"version":1,"type":4}],"TagContent":"TOP500 第10名","Privilege":8,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":4611384,"Uploader":"","Duration":297,"SQFailProcess":4,"OriSongName":"小半","A320Privilege":10,"FileName":"陈粒 - 小半","ResFileSize":128455956,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"34C52ED693A5519D72DA623EBA0E7DE1","PublishTime":"","Audioid":363537969,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"李荣浩","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":28164599,"AlbumAux":"","HQDuration":275,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20241016\/20241016175101115675.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"ogg_128_filesize":3064050,"display_rate":0,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db411ffffff3fc074","attr0":2134884468,"attr1":1747189759},"hash_multitrack":"6A2C5E7DCA4E5DA1B70E245D772DA7C1","hash_offset":{"clip_hash":"AE1F7B7C65EABCB300EBEB4B57C2F478","start_byte":0,"end_ms":60000,"end_byte":960113,"file_type":0,"start_ms":0,"offset_hash":"6A1D28108F84B50C917D358A6CC20A50"},"cid":402261960,"display":0,"ogg_320_hash":"57FA42A7EE6A5EC6F6AB35FB2F22DF43","ipmap":{"attr0":1107300352},"appid_block":"3124","ogg_128_hash":"4839A269E37919D74A36DDA58368A976","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20241016\/20241016175101115675.jpg","ogg_320_filesize":10431630},"UploaderContent":"","FileSize":4415928,"IsOriginal":0,"FileHash":"9DA7851E2BF83B18C74CBBAB461CEFDD","FoldType":0,"Grp":[],"ID":"644833397","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"106374641","AlbumName":"黑马","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"B21CA28AFC6D3FB7B1F9964D330F689F","id":"12602115"}],"OtherName":"","SongName":"恋人","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":275,"HQFileSize":11039079,"MixSongID":"644833397","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":275,"ResBitrate":1629,"HiFiQuality":3,"ResFileHash":"CE16C9658C82664796DBB7585588AAC5","SingerId":[93475],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":363537969,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"李荣浩","ip_id":0,"id":93475}],"mvTotal":0,"MvHash":"B21CA28AFC6D3FB7B1F9964D330F689F","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":816,"RankId":8888,"PublishDate":"2024-06-28","HQFileHash":"C8DE6F8214A0556AC3F0BE4872A6EED8","TopicUrl":"","TagDetails":[{"content":"TOP500 第9名","rankid":8888,"version":1,"type":4}],"TagContent":"TOP500 第9名","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":4460102,"Uploader":"","Duration":275,"SQFailProcess":4,"OriSongName":"恋人","A320Privilege":10,"FileName":"李荣浩 - 恋人","ResFileSize":56219830,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"83368470292244265486BF864701222C","PublishTime":"","Audioid":281733352,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"G.E.M. 邓紫棋","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":25554595,"AlbumAux":"","HQDuration":253,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20240122\/20240122143605898824.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"db411ffffff3fc074","attr0":2134884468,"attr1":1747189759},"pay_block_tpl":1,"hash_multitrack":"D1F631F721B19BC5B1F19F67AFA117B3","cid":348476281,"ogg_128_filesize":2952865,"ogg_320_hash":"878D0D6E847F402299D29D4295BC21CB","ipmap":{"attr0":1107300352},"hash_offset":{"clip_hash":"3108E909E309C4886E05826B9B32BFF6","start_byte":0,"end_ms":60000,"end_byte":960139,"file_type":0,"start_ms":0,"offset_hash":"972CBFD7C990B834FF0EBA58CD1A4565"},"ogg_128_hash":"A76E5E3C04E98737DBDD0C8C550EDAE5","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20240122\/20240122143605898824.jpg","ogg_320_filesize":9775150},"UploaderContent":"","FileSize":4061107,"IsOriginal":0,"FileHash":"AB05B8F658851282DCB2CBAD548AEB9B","FoldType":0,"Grp":[],"ID":"590964610","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"82564821","AlbumName":"T.I.M.E.","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"4CDC3359A8D45114153D68F26AEF0A9A","id":"11537094"}],"OtherName":"","SongName":"唯一","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":253,"HQFileSize":10152444,"MixSongID":"590964610","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":253,"ResBitrate":1607,"HiFiQuality":3,"ResFileHash":"983AA9AF17E1688CC70EDEAAF6256D5B","SingerId":[4490],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":281733352,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"G.E.M. 邓紫棋","ip_id":0,"id":4490}],"mvTotal":0,"MvHash":"4CDC3359A8D45114153D68F26AEF0A9A","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":805,"RankId":8888,"PublishDate":"2023-09-24","HQFileHash":"7DD13522B6C143A39E10507B74B0A876","TopicUrl":"","TagDetails":[{"content":"TOP500 第95名","rankid":8888,"version":1,"type":4}],"TagContent":"TOP500 第95名","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":3859675,"Uploader":"","Duration":253,"SQFailProcess":4,"OriSongName":"唯一","A320Privilege":10,"FileName":"G.E.M. 邓紫棋 - 唯一","ResFileSize":51002993,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"A94C863610A66DACF65B1B4BE9185FD3","PublishTime":"","Audioid":67347251,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"王艳薇","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":29808897,"AlbumAux":"","HQDuration":233,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250725\/20250725103502185296.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":6,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58735744,"musicpack_advance":1,"ogg_128_filesize":2756034,"display_rate":0,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db411ffffff3fe475","attr0":2134893685,"attr1":1747189759},"hash_multitrack":"8B3E8F05521393A595C02D98593F0F88","hash_offset":{"clip_hash":"2BFC7B719540F88A313C6AAAFE8408C8","start_byte":0,"end_ms":60000,"end_byte":960129,"file_type":0,"start_ms":0,"offset_hash":"12CE4DF2A9F865C12A640284BB6A5646"},"cid":89842849,"display":0,"ogg_320_hash":"E8291402D0C3F45405C11241C7571C20","ipmap":{"attr0":1107300352},"appid_block":"2906,3124","ogg_128_hash":"7E65FEB37CDF1712A942A99EBD07B7F3","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250725\/20250725103502185296.jpg","ogg_320_filesize":10217947},"UploaderContent":"","FileSize":3743448,"IsOriginal":1,"FileHash":"A9C377CC1B9931F0CE81907E23E4D588","FoldType":0,"Grp":[],"ID":"249125712","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"36181053","AlbumName":"离开我的依赖","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"61337E5A908D11ABF36E1A101FC3D93A","id":"2278173"}],"OtherName":"","SongName":"离开我的依赖","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":233,"HQFileSize":9358312,"MixSongID":"249125712","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":233,"ResBitrate":1723,"HiFiQuality":3,"ResFileHash":"F68A5DC1D0A5EC34E9CD98AAB5BFA8AC","SingerId":[710027],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":67347251,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"王艳薇","ip_id":0,"id":710027}],"mvTotal":0,"MvHash":"61337E5A908D11ABF36E1A101FC3D93A","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":1019,"RankId":0,"PublishDate":"2020-02-17","HQFileHash":"2D180C85ADADDC7FA19AD9B6DD827821","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":3673281,"Uploader":"","Duration":233,"SQFailProcess":4,"OriSongName":"离开我的依赖","A320Privilege":10,"FileName":"王艳薇 - 离开我的依赖","ResFileSize":50381805,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"78E125D093837C463270EAC03BB9D8A9","PublishTime":"","Audioid":20505418,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"周杰伦","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":31729524,"AlbumAux":"","HQDuration":269,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20230920\/20230920142503632013.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234885128},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"ogg_128_filesize":2927865,"display_rate":1,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db411ffffff3fc074","attr0":2134884468,"attr1":1747189759},"hash_multitrack":"5B431FE8060813D77889A7838B0EBA76","hash_offset":{"clip_hash":"BBB8430047ADCBAFD1920315B38DDC0A","start_byte":0,"end_ms":60000,"end_byte":960115,"file_type":0,"start_ms":0,"offset_hash":"C31E6556C4E262FB19A88FAE85A2E103"},"cid":2456863,"display":32,"ogg_320_hash":"6BB59E9DAFACFE4332E07F9E9841E912","ipmap":{"attr0":2200130555908},"appid_block":"3124","ogg_128_hash":"D6E0229D1BCD4453981743F6B53F9D75","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20230920\/20230920142503632013.jpg","ogg_320_filesize":10331568},"UploaderContent":"","FileSize":4317292,"IsOriginal":1,"FileHash":"B3A52A7A958BF0AED0EBFBA2E9A818B7","FoldType":0,"Grp":[],"ID":"32100650","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"966846","AlbumName":"叶惠美","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"92B86DA2E11C3C84DE3A944ED12D97F1","id":"117613"}],"OtherName":"","SongName":"晴天","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":269,"HQFileSize":10792943,"MixSongID":"32100650","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":269,"ResBitrate":1642,"HiFiQuality":3,"ResFileHash":"D667BC5EE93F201126697CB3BA745009","SingerId":[3520],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":20505418,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"周杰伦","ip_id":0,"id":3520}],"mvTotal":0,"MvHash":"92B86DA2E11C3C84DE3A944ED12D97F1","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":940,"RankId":0,"PublishDate":"2003-07-31","HQFileHash":"1B56126A8A03924F1DD066259C095CBC","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":3512102,"Uploader":"","Duration":269,"SQFailProcess":4,"OriSongName":"晴天","A320Privilege":10,"FileName":"周杰伦 - 晴天","ResFileSize":55397039,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"F9ED36771CE6A071C2A4C210E4E68F56","PublishTime":"","Audioid":348980,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"杨丞琳","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":33618441,"AlbumAux":"","HQDuration":260,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250716\/20250716140851912935.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":6,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"fdb411fefeff3fc075","attr0":2134884469,"attr1":1747189245},"pay_block_tpl":1,"hash_multitrack":"B41A312A01FC91BA2A8F61B874BA3D11","cid":7239370,"ogg_128_filesize":3057034,"ogg_320_hash":"579A4A3F88BB10B2D16F5665694E6347","ipmap":{"attr0":2475008462848},"hash_offset":{"clip_hash":"DF94691ACA9D2FBA526D7FB0F46F430D","start_byte":0,"end_ms":60000,"end_byte":960145,"file_type":0,"start_ms":0,"offset_hash":"F82E75B11A112628EF482DE0972E75B3"},"ogg_128_hash":"8470D11502739E745406AB3585EC95D0","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250716\/20250716140851912935.jpg","ogg_320_filesize":11020981},"UploaderContent":"","FileSize":4168946,"IsOriginal":1,"FileHash":"2592FFA57A2D8B1A16F18D991B7098CD","FoldType":0,"Grp":[],"ID":"65727949","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"2694607","AlbumName":"雨爱","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"8290FA048A9E145B00F3FCAA97602D92","id":"52800"}],"OtherName":"","SongName":"雨爱","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":260,"HQFileSize":10421564,"MixSongID":"65727949","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":260,"ResBitrate":1051,"HiFiQuality":3,"ResFileHash":"3E483896EA485A57E390A7717E615486","SingerId":[6538],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":348980,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"杨丞琳","ip_id":0,"id":6538}],"mvTotal":0,"MvHash":"8290FA048A9E145B00F3FCAA97602D92","SuperFileSize":0,"Auxiliary":"《披荆斩棘5》第1期表演曲目原曲","SQExtName":"flac","SQBitrate":1032,"RankId":0,"PublishDate":"2010-01-04","HQFileHash":"E72D5EEC94706BEF1BB6DCA4DE1CF09F","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":3178853,"Uploader":"","Duration":260,"SQFailProcess":4,"OriSongName":"雨爱","A320Privilege":10,"FileName":"杨丞琳 - 雨爱","ResFileSize":34229336,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"3F5A3581CA64B1C3AFABA51542E1DD7B","PublishTime":"","Audioid":176451,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"王力宏","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":27653460,"AlbumAux":"","HQDuration":238,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250125\/20250125121607724523.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58735744,"musicpack_advance":1,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"db411ffffff3fc074","attr0":2134884468,"attr1":1747189759},"pay_block_tpl":1,"hash_multitrack":"E71E06F820A34F3493F8CA79F4EC800D","cid":5499263,"ogg_128_filesize":2666520,"ogg_320_hash":"AF2D25AEF4BA2B37B231DB52EB53CBB1","ipmap":{"attr0":2475008462850},"hash_offset":{"clip_hash":"291D6C679104DC97E9BAC55173DAC6BB","start_byte":0,"end_ms":60000,"end_byte":960119,"file_type":0,"start_ms":0,"offset_hash":"5FDE60878739A074AFA18D002C31691B"},"ogg_128_hash":"5E979C010F247B46F5966E03307178D0","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250125\/20250125121607724523.jpg","ogg_320_filesize":9588670},"UploaderContent":"","FileSize":3822432,"IsOriginal":1,"FileHash":"EC25602B56D5DAE36B27E82780FC6A22","FoldType":0,"Grp":[],"ID":"68426073","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"2996462","AlbumName":"心中的日月","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"EC02FBD3C92684545032936477DBCE5D","id":"1010079"}],"OtherName":"","SongName":"爱错","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":238,"HQFileSize":9555788,"MixSongID":"68426073","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":238,"ResBitrate":952,"HiFiQuality":3,"ResFileHash":"37A31E2833C6A67D5BCCEA48CA430838","SingerId":[2724],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":176451,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"王力宏","ip_id":0,"id":2724}],"mvTotal":0,"MvHash":"EC02FBD3C92684545032936477DBCE5D","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":926,"RankId":0,"PublishDate":"2004-12-31","HQFileHash":"DC42D3833E7C10CC4EBE52849993FDE2","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2977342,"Uploader":"","Duration":238,"SQFailProcess":4,"OriSongName":"爱错","A320Privilege":10,"FileName":"王力宏 - 爱错","ResFileSize":28430354,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"07878C02FF6F0278648C48C7656DFF34","PublishTime":"","Audioid":285029,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"孙燕姿","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":29907704,"AlbumAux":"","HQDuration":289,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20221230\/20221230052215394603.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58735744,"musicpack_advance":1,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"db4107ffff73fc035","attr0":2000666677,"attr1":1746993151},"pay_block_tpl":1,"hash_multitrack":"FC61CABED1D1D75910C5024406FEDFFD","cid":2456750,"ogg_128_filesize":3199344,"ogg_320_hash":"28B5672F5FE07BB1DF922EE45C33A756","ipmap":{"attr0":2475008462848},"hash_offset":{"clip_hash":"5A78B54AB2B2D928635326F8D987124F","start_byte":0,"end_ms":60000,"end_byte":960535,"file_type":0,"start_ms":0,"offset_hash":"5C00937002202D4589580CFFB3B7D1E3"},"ogg_128_hash":"F7B44859263261EB4F9D155425830779","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20221230\/20221230052215394603.jpg","ogg_320_filesize":10775967},"UploaderContent":"","FileSize":4626166,"IsOriginal":1,"FileHash":"1A3CAACB1E361DAF217A2383E9C8E292","FoldType":0,"Grp":[],"MvTrac":3,"ID":"32256029","Type":"audio","Bitrate":128,"SQPrice":200,"isPrepublish":0,"ExtName":"mp3","mvdata":[{"typ":0,"trk":"3","hash":"9C34C60A4A626CD0FB1904D831AF3819","id":"676203"}],"TopID":0,"AlbumPrivilege":10,"AlbumID":"984086","Category":1,"SuperExtName":"","AlbumName":"逆光","OtherName":"","SongName":"我怀念的","ASQPrivilege":10,"AudioCdn":0,"SourceID":0,"SQDuration":289,"HQFileSize":11565124,"MixSongID":"32256029","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":0,"ResBitrate":0,"HiFiQuality":2,"ResFileHash":"","SingerId":[5826],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":285029,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"孙燕姿","ip_id":0,"id":5826}],"mvTotal":0,"MvHash":"9C34C60A4A626CD0FB1904D831AF3819","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":827,"RankId":0,"PublishDate":"2007-03-22","HQFileHash":"77FA03612A4CFCD71C7FD29394937AEB","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2971583,"Uploader":"","Duration":289,"SQFailProcess":4,"OriSongName":"我怀念的","A320Privilege":10,"FileName":"孙燕姿 - 我怀念的","ResFileSize":0,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"61D1ADF80F53B5EFE74A17EB751D03DA","PublishTime":"","Audioid":15327235,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"薛之谦","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":25307865,"AlbumAux":"","HQDuration":261,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250207\/20250207161328731643.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58735744,"musicpack_advance":1,"ogg_128_filesize":2890335,"display_rate":0,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db411ffffff3fc075","attr0":2134884469,"attr1":1747189759},"hash_multitrack":"AC902E132977A4602CD0D9C2B5BFC1E9","hash_offset":{"clip_hash":"D3179F332153658F8B85E77E5ABD110C","start_byte":0,"end_ms":60000,"end_byte":960113,"file_type":0,"start_ms":0,"offset_hash":"64BF3CCD82D2B8C1548A1446E8556847"},"cid":2481985,"display":0,"ogg_320_hash":"88F7FFDC23110CAFE2E018528CDDA6A7","ipmap":{"attr0":2200130555904},"appid_block":"3124","ogg_128_hash":"06DCBAEE53E39E21EF80B91FA804626E","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250207\/20250207161328731643.jpg","ogg_320_filesize":10261245},"UploaderContent":"","FileSize":4181035,"IsOriginal":1,"FileHash":"097E777171F692855EAE98B6965F9477","FoldType":0,"Grp":[],"ID":"128180951","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"14456909","AlbumName":"绅士","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"DEA9ACFE7E6201EB7E384063E700734E","id":"180472"}],"OtherName":"","SongName":"演员","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":261,"HQFileSize":10452304,"MixSongID":"128180951","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":261,"ResBitrate":1480,"HiFiQuality":3,"ResFileHash":"6533406512471EF54A96CAD8465D393B","SingerId":[3060],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":15327235,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"薛之谦","ip_id":0,"id":3060}],"mvTotal":0,"MvHash":"DEA9ACFE7E6201EB7E384063E700734E","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":774,"RankId":0,"PublishDate":"2015-06-05","HQFileHash":"06156D13E628E200728EDAA5E58EF9EC","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2827077,"Uploader":"","Duration":261,"SQFailProcess":4,"OriSongName":"演员","A320Privilege":10,"FileName":"薛之谦 - 演员","ResFileSize":48354702,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"6CDBA2636721C970533AC1540698AE97","PublishTime":"","Audioid":27645900,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"街道办GDC、欧阳耀莹","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":24768387,"AlbumAux":"","HQDuration":204,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20240913\/20240913144404471685.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"粤语","cpy_attr0":58735808,"musicpack_advance":1,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"db41180007f3fe475","attr0":2134893685,"attr1":1747124224},"pay_block_tpl":1,"hash_multitrack":"EC158403E8702334CDF69EE5D2C85000","cid":34960649,"ogg_128_filesize":2445468,"ogg_320_hash":"8826BB41C099C63042FC1741C8CC7BE9","ipmap":{"attr0":1074008096},"hash_offset":{"clip_hash":"36927364FB35BC831BEC64E3BCDE72A9","start_byte":0,"end_ms":60000,"end_byte":960141,"file_type":0,"start_ms":0,"offset_hash":"568B99EE4DFF3FD61C850598BB2DD344"},"ogg_128_hash":"25292A4B4DD2ACE00470BE99461C7236","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20240913\/20240913144404471685.jpg","ogg_320_filesize":8806090},"UploaderContent":"","FileSize":3281197,"IsOriginal":1,"FileHash":"E84947402A5E0952FA067566C10264CB","FoldType":0,"Grp":[],"ID":"88156227","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"8543461","AlbumName":"春娇与志明","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"261EF9547AAE588A869987A2C51A2983","id":"654974"}],"OtherName":"","SongName":"春娇与志明","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":204,"HQFileSize":8202141,"MixSongID":"88156227","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":204,"ResBitrate":1669,"HiFiQuality":3,"ResFileHash":"0348EA5EEABC564DE5E63CA85DD72439","SingerId":[210138,200294],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":27645900,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"街道办GDC","ip_id":0,"id":210138},{"name":"欧阳耀莹","ip_id":0,"id":200294}],"mvTotal":0,"MvHash":"261EF9547AAE588A869987A2C51A2983","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":966,"RankId":0,"PublishDate":"2017-06-25","HQFileHash":"044517F56CD65EC149D8FAE967483363","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2805236,"Uploader":"","Duration":204,"SQFailProcess":4,"OriSongName":"春娇与志明","A320Privilege":10,"FileName":"街道办GDC、欧阳耀莹 - 春娇与志明","ResFileSize":42783536,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"8BED19838D12E7C66740F3E98E1D3985","PublishTime":"","Audioid":20200,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"郭静","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":31892252,"AlbumAux":"","HQDuration":280,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20210114\/20210114104940829988.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"db4107efef73fc034","attr0":2000666676,"attr1":1746992637},"pay_block_tpl":1,"hash_multitrack":"2F68E5EB49F0DE4CFECCBF124D63A46A","cid":3747677,"ogg_128_filesize":3336579,"ogg_320_hash":"546F7D0720300BBD41D15FE62CE2060D","ipmap":{"attr0":2475008462848},"hash_offset":{"clip_hash":"ECF028EB9ED1A4B8505D643AE017242B","start_byte":0,"end_ms":60000,"end_byte":960121,"file_type":0,"start_ms":0,"offset_hash":"46E81B738985D4AD98B3C33488CC0A33"},"ogg_128_hash":"8792A29922778CB1D35A6BB0BF58888C","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20210114\/20210114104940829988.jpg","ogg_320_filesize":11629319},"UploaderContent":"","FileSize":4492005,"IsOriginal":1,"FileHash":"D8E857250D8EEA9C5FAFDAF7857640A5","FoldType":0,"Grp":[],"MvTrac":3,"ID":"32138785","Type":"audio","Bitrate":128,"SQPrice":200,"isPrepublish":0,"ExtName":"mp3","mvdata":[{"typ":0,"trk":"3","hash":"D2B1C33AB50E4B732A8B81822BEC1831","id":"13765334"}],"TopID":0,"AlbumPrivilege":10,"AlbumID":"971139","Category":1,"SuperExtName":"","AlbumName":"下一个天亮","OtherName":"","SongName":"爱情讯息","ASQPrivilege":10,"AudioCdn":0,"SourceID":0,"SQDuration":280,"HQFileSize":11229716,"MixSongID":"32138785","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":0,"ResBitrate":0,"HiFiQuality":2,"ResFileHash":"","SingerId":[4663],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":20200,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"郭静","ip_id":0,"id":4663}],"mvTotal":0,"MvHash":"D2B1C33AB50E4B732A8B81822BEC1831","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":908,"RankId":0,"PublishDate":"2008-05-09","HQFileHash":"7E91D1710EC0DA7F449C5FB94F925C25","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2518775,"Uploader":"","Duration":280,"SQFailProcess":4,"OriSongName":"爱情讯息","A320Privilege":10,"FileName":"郭静 - 爱情讯息","ResFileSize":0,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"378C3BE676D79DB50064B635285139D3","PublishTime":"","Audioid":977121,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"薛之谦","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":23056006,"AlbumAux":"","HQDuration":242,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20200407\/20200407151818862082.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"ogg_128_filesize":2633895,"display_rate":0,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db411ffffff3fe475","attr0":2134893685,"attr1":1747189759},"hash_multitrack":"E1D348F7B07371839420893A8D9105B9","hash_offset":{"clip_hash":"421E27ECFA87C5B5244270BBD9AC509D","start_byte":0,"end_ms":60000,"end_byte":960113,"file_type":0,"start_ms":0,"offset_hash":"F7F42790F2D705E2C089559C15DFC0FE"},"cid":22483004,"display":0,"ogg_320_hash":"137FA5D1E7347F4A5E1E730244A696F6","ipmap":{"attr0":2200130555904},"appid_block":"3124","ogg_128_hash":"837447309D1670167E70ABF6C6625B6F","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20200407\/20200407151818862082.jpg","ogg_320_filesize":8917484},"UploaderContent":"","FileSize":3875507,"IsOriginal":1,"FileHash":"2A8911EAD4838BF967CF5A300D787E53","FoldType":0,"Grp":[],"ID":"32042280","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"960327","AlbumName":"意外","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"E51334A642C43B79973B9962E68EDE18","id":"596108"}],"OtherName":"","SongName":"其实","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":242,"HQFileSize":9688090,"MixSongID":"32042280","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":242,"ResBitrate":797,"HiFiQuality":3,"ResFileHash":"87BB7B1C6C5C00A1BBD4AD00E94DC80E","SingerId":[3060],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":977121,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"薛之谦","ip_id":0,"id":3060}],"mvTotal":0,"MvHash":"E51334A642C43B79973B9962E68EDE18","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":761,"RankId":0,"PublishDate":"2013-11-11","HQFileHash":"5464DF133A7026E315B6C67E04EE6F46","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2400534,"Uploader":"","Duration":242,"SQFailProcess":4,"OriSongName":"其实","A320Privilege":10,"FileName":"薛之谦 - 其实","ResFileSize":24150855,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"D1D7835F9BED257E613A2C854333667B","PublishTime":"","Audioid":254112,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"周杰伦","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":26174554,"AlbumAux":"","HQDuration":240,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250125\/20250125121745628430.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234885128},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"ogg_128_filesize":2582556,"display_rate":1,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db411ffffff3fc034","attr0":2134884404,"attr1":1747189759},"hash_multitrack":"A78CD43CE69F8B5AAC407C99DF43473C","hash_offset":{"clip_hash":"80F96B166376990DB8288F2444FD0A5B","start_byte":0,"end_ms":60000,"end_byte":960115,"file_type":0,"start_ms":0,"offset_hash":"FED2BB4428855531A6FCA8681C62C9C7"},"cid":2556354,"display":32,"ogg_320_hash":"2049705BAF03190EFFA0077963EDD46F","ipmap":{"attr0":2200130555904},"appid_block":"3124","ogg_128_hash":"703894710732A98EAA9FCB6A68863F52","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250125\/20250125121745628430.jpg","ogg_320_filesize":8929800},"UploaderContent":"","FileSize":3843170,"IsOriginal":1,"FileHash":"FBC234520FED713C30C1C026E7352770","FoldType":0,"Grp":[],"MvTrac":3,"ID":"32144422","Type":"audio","Bitrate":128,"SQPrice":200,"isPrepublish":0,"ExtName":"mp3","mvdata":[{"typ":0,"trk":"3","hash":"004C5BD7B7B322330821A12812C0B907","id":"756760"}],"TopID":0,"AlbumPrivilege":10,"AlbumID":"971783","Category":1,"SuperExtName":"","AlbumName":"七里香","OtherName":"","SongName":"搁浅","ASQPrivilege":10,"AudioCdn":0,"SourceID":0,"SQDuration":240,"HQFileSize":9607431,"MixSongID":"32144422","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":0,"ResBitrate":0,"HiFiQuality":2,"ResFileHash":"","SingerId":[3520],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":254112,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"周杰伦","ip_id":0,"id":3520}],"mvTotal":0,"MvHash":"004C5BD7B7B322330821A12812C0B907","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":871,"RankId":0,"PublishDate":"2004-08-03","HQFileHash":"581C52E119C8F25A965C7C2F3FB73DBD","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2372013,"Uploader":"","Duration":240,"SQFailProcess":4,"OriSongName":"搁浅","A320Privilege":10,"FileName":"周杰伦 - 搁浅","ResFileSize":0,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"E94D32013B4E5E6200075BCCAB96787C","PublishTime":"","Audioid":327075,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"周杰伦","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":29671753,"AlbumAux":"","HQDuration":264,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20241118\/20241118160622508429.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234885128},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"ogg_128_filesize":2898630,"display_rate":1,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db401ffffbf3fc035","attr0":1061142581,"attr1":1745092607},"hash_multitrack":"C30340410860BFC4E77F5EBB04888AAA","hash_offset":{"clip_hash":"E56829AC9AF0418BAFB49BDF50D1E998","start_byte":0,"end_ms":137300,"end_byte":2197274,"file_type":0,"start_ms":77300,"offset_hash":"9A25380A6DEA2A97A909DDEF3CBA2AF6"},"cid":2556468,"display":32,"ogg_320_hash":"03DD3DD1804EC99E2BE01DEEE8C94DC8","ipmap":{"attr0":2200130555904},"appid_block":"3124","ogg_128_hash":"BEBAC1F90C3F9657490D620DE9936E6A","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20241118\/20241118160622508429.jpg","ogg_320_filesize":10619087},"UploaderContent":"","FileSize":4234954,"IsOriginal":1,"FileHash":"3328808CECBD1A1038166003840FDDD7","FoldType":0,"Grp":[],"MvTrac":3,"ID":"32042821","Type":"audio","Bitrate":128,"SQPrice":200,"isPrepublish":0,"ExtName":"mp3","mvdata":[{"typ":0,"trk":"3","hash":"4E50F6ACB1198C49F8F47C1B69E01859","id":"29532"}],"TopID":0,"AlbumPrivilege":10,"AlbumID":"960399","Category":1,"SuperExtName":"","AlbumName":"魔杰座","OtherName":"","SongName":"花海","ASQPrivilege":10,"AudioCdn":0,"SourceID":0,"SQDuration":264,"HQFileSize":10587098,"MixSongID":"32042821","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":0,"ResBitrate":0,"HiFiQuality":2,"ResFileHash":"","SingerId":[3520],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":327075,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"周杰伦","ip_id":0,"id":3520}],"mvTotal":0,"MvHash":"4E50F6ACB1198C49F8F47C1B69E01859","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":896,"RankId":0,"PublishDate":"2008-10-15","HQFileHash":"8E39ECA364361E4A0652E77B8B3E6617","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2297209,"Uploader":"","Duration":264,"SQFailProcess":4,"OriSongName":"花海","A320Privilege":10,"FileName":"周杰伦 - 花海","ResFileSize":0,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"81E57867295FFC99208142B60628167F","PublishTime":"","Audioid":149787,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"陈奕迅","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":27911997,"AlbumAux":"","HQDuration":259,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250822\/20250822164712115635.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"粤语","cpy_attr0":58727552,"musicpack_advance":1,"ogg_128_filesize":2877352,"display_rate":0,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db411fefeff3fc075","attr0":2134884469,"attr1":1747189245},"hash_multitrack":"89E7DC9E917A4BF401C713A48BC0DDE3","hash_offset":{"clip_hash":"A1913149C9A57BC1A4B526BE781C9C86","start_byte":0,"end_ms":60000,"end_byte":960187,"file_type":0,"start_ms":0,"offset_hash":"7CC97CB3A081E180257FE2CC0EE05CF0"},"cid":7344031,"display":0,"ogg_320_hash":"7D69787FA701A7A01014A74FACB020F6","ipmap":{"attr0":2200097263616},"appid_block":"2906,3124","ogg_128_hash":"4210525B239547114F803E09B94058AD","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20250822\/20250822164712115635.jpg","ogg_320_filesize":9977246},"UploaderContent":"","FileSize":4147255,"IsOriginal":1,"FileHash":"0433F1A94FA162B20FB8AE576A951D6B","FoldType":0,"Grp":[],"ID":"32185522","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"976404","AlbumName":"What's Going On...? (Remastered 2019)","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"DE803B65777056008831450625DDD814","id":"952046"}],"OtherName":"","SongName":"富士山下","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":259,"HQFileSize":10367741,"MixSongID":"32185522","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":259,"ResBitrate":879,"HiFiQuality":3,"ResFileHash":"E5195D4F4851325DCBA07EEAA07130C6","SingerId":[420],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":149787,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"陈奕迅","ip_id":0,"id":420}],"mvTotal":0,"MvHash":"DE803B65777056008831450625DDD814","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":861,"RankId":0,"PublishDate":"2006-11-23","HQFileHash":"4C2A1E8AB2FA1AA0A55B8C05CFBF7152","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2273285,"Uploader":"","Duration":259,"SQFailProcess":4,"OriSongName":"富士山下","A320Privilege":10,"FileName":"陈奕迅 - 富士山下","ResFileSize":28488628,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"4E04284CC38F2554EF2C8F314E185319","PublishTime":"","Audioid":37922503,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"张紫豪","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":25840796,"AlbumAux":"","HQDuration":240,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20180827\/20180827203224857639.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":6,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58743936,"musicpack_advance":1,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"db411ffffff3fc075","attr0":2134884469,"attr1":1747189759},"pay_block_tpl":1,"hash_multitrack":"81CB4D37BD93A7AE3E1AB49F80105EF7","cid":33159408,"ogg_128_filesize":2677118,"ogg_320_hash":"42CDC575BADCF126E01272D16A8107F4","ipmap":{"attr0":17213427712},"hash_offset":{"clip_hash":"143CC46AD846C821C1D06C1BF99A5A91","start_byte":0,"end_ms":60000,"end_byte":960121,"file_type":0,"start_ms":0,"offset_hash":"9F6743B5F46D04E04DA1523151D45BA5"},"ogg_128_hash":"400704B32CC2F08E7E7786DF9DE9161F","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20180827\/20180827203224857639.jpg","ogg_320_filesize":9176984},"UploaderContent":"","FileSize":3855453,"IsOriginal":1,"FileHash":"6079A2ACBA5E782FE24695FDFCDB1887","FoldType":0,"Grp":[],"ID":"251721168","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"9618875","AlbumName":"可不可以","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"734C5540479E5FEF6918EE12D361495C","id":"3516981"}],"OtherName":"","SongName":"可不可以","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":240,"HQFileSize":9638336,"MixSongID":"251721168","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":240,"ResBitrate":910,"HiFiQuality":3,"ResFileHash":"CCE4A3634857CC8044AD88D9B009DAFB","SingerId":[789204],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":37922503,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"张紫豪","ip_id":0,"id":789204}],"mvTotal":0,"MvHash":"734C5540479E5FEF6918EE12D361495C","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":857,"RankId":0,"PublishDate":"2018-05-03","HQFileHash":"1C8C35056D2E2AC843A3630049583706","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2267604,"Uploader":"","Duration":240,"SQFailProcess":4,"OriSongName":"可不可以","A320Privilege":10,"FileName":"张紫豪 - 可不可以","ResFileSize":27433585,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"29EE08103A33AD6707E71FD5F1CC239A","PublishTime":"","Audioid":907824,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"张芸京","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":25365281,"AlbumAux":"","HQDuration":212,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20221125\/20221125063514484979.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58735744,"musicpack_advance":1,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"db411ffffff3ffc75","attr0":2134899829,"attr1":1747189759},"pay_block_tpl":1,"hash_multitrack":"8A1FFE3854B3C7419084EFD63A609919","cid":2456922,"ogg_128_filesize":2443284,"ogg_320_hash":"3B10FCAADBA5B82F5587F15CC96D05A9","ipmap":{"attr0":2200130555904},"hash_offset":{"clip_hash":"EC92BCB776E385840ADA00C07C4AE43B","start_byte":0,"end_ms":60000,"end_byte":960115,"file_type":0,"start_ms":0,"offset_hash":"32AAF062B7299F8C9B0EE5E666C44103"},"ogg_128_hash":"176D089A06029A8F3144EDB6D5C2DF27","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20221125\/20221125063514484979.jpg","ogg_320_filesize":8426613},"UploaderContent":"","FileSize":3407813,"IsOriginal":1,"FileHash":"4A544525C1F78DBDF25361DB0E255495","FoldType":0,"Grp":[],"ID":"32118015","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"968788","AlbumName":"破天荒","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"B114D5899B2E94A0865850D6025B09EC","id":"677145"}],"OtherName":"","SongName":"偏爱","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":212,"HQFileSize":8519245,"MixSongID":"32118015","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":212,"ResBitrate":976,"HiFiQuality":3,"ResFileHash":"27B39645A74D5A47F793E9207BBD97AE","SingerId":[6822],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":907824,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"张芸京","ip_id":0,"id":6822}],"mvTotal":0,"MvHash":"B114D5899B2E94A0865850D6025B09EC","SuperFileSize":0,"Auxiliary":"《仙剑奇侠传三》电视剧插曲","SQExtName":"flac","SQBitrate":952,"RankId":0,"PublishDate":"2009-05-08","HQFileHash":"F69A2F14885BF1A3B6E236584045D1B2","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2229775,"Uploader":"","Duration":212,"SQFailProcess":4,"OriSongName":"偏爱","A320Privilege":10,"FileName":"张芸京 - 偏爱","ResFileSize":25997874,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"30A29CC648163DD4F265C6E7B4E07C57","PublishTime":"","Audioid":339796,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"周杰伦","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":26170419,"AlbumAux":"","HQDuration":239,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20220705\/20220705143006989099.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":6,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"ogg_128_filesize":2700910,"display_rate":0,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db411ffffff3fc075","attr0":2134884469,"attr1":1747189759},"hash_multitrack":"85568A05EE0200F50547925517FAA5B7","hash_offset":{"clip_hash":"9877793C360F13ED36011712BB613131","start_byte":0,"end_ms":60000,"end_byte":960117,"file_type":0,"start_ms":0,"offset_hash":"1D7E04573B8A2FDF51122C3DC0B4A8FB"},"cid":2556436,"display":0,"ogg_320_hash":"CFD06B52F79DE9B197830B07722E35ED","ipmap":{"attr0":2200197664768},"appid_block":"3124","ogg_128_hash":"0B60A243C1F821719E955AE06492C8C8","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20220705\/20220705143006989099.jpg","ogg_320_filesize":9522900},"UploaderContent":"","FileSize":3830789,"IsOriginal":1,"FileHash":"37A8F50A9EC3B267C3CC6BEC633D9C4A","FoldType":0,"Grp":[],"ID":"32218352","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"979856","AlbumName":"我很忙","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"DC602A8579C0AC1E2895543FFC2C7DAF","id":"592096"}],"OtherName":"","SongName":"青花瓷","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":239,"HQFileSize":9576683,"MixSongID":"32218352","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":239,"ResBitrate":897,"HiFiQuality":3,"ResFileHash":"A86A3D8AFABE012A0095CB0EEBF55D50","SingerId":[3520],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":339796,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"周杰伦","ip_id":0,"id":3520}],"mvTotal":0,"MvHash":"DC602A8579C0AC1E2895543FFC2C7DAF","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":874,"RankId":0,"PublishDate":"2007-11-02","HQFileHash":"D38BFF1043FEC27B8D40F40DA953CB0E","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2217950,"Uploader":"","Duration":239,"SQFailProcess":4,"OriSongName":"青花瓷","A320Privilege":10,"FileName":"周杰伦 - 青花瓷","ResFileSize":26858410,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"A7A5CEEE53F47A01CD2EB57FABF0BD8F","PublishTime":"","Audioid":152487,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"蔡健雅","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":25470183,"AlbumAux":"","HQDuration":206,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20200620\/20200620064627514694.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58735744,"musicpack_advance":1,"ogg_128_filesize":2315581,"display_rate":0,"cpy_level":1,"pay_block_tpl":1,"qualitymap":{"bits":"db411ffffff3fc075","attr0":2134884469,"attr1":1747189759},"hash_multitrack":"D29E1857E9D2AF60D6DE674493E60569","hash_offset":{"clip_hash":"ADF215689D94276D8BB5AC54E82992B6","start_byte":0,"end_ms":60000,"end_byte":960125,"file_type":0,"start_ms":0,"offset_hash":"7F6340A4287AD43AD000FC5E32EF5BAA"},"cid":22464222,"display":0,"ogg_320_hash":"644397AC77F0BBBBA77EC3E33E923109","ipmap":{"attr0":2200130555904},"appid_block":"3124","ogg_128_hash":"63C5F6C9B05807F1180E68D71E3CC18B","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20200620\/20200620064627514694.jpg","ogg_320_filesize":8258051},"UploaderContent":"","FileSize":3306677,"IsOriginal":1,"FileHash":"055A804B8A3CCC05240D08F8FF1F7DE8","FoldType":0,"Grp":[],"ID":"32204446","MvTrac":3,"isPrepublish":0,"Type":"audio","Bitrate":128,"SQPrice":200,"ASQPrivilege":10,"ExtName":"mp3","TopID":0,"AlbumPrivilege":10,"AlbumID":"978459","AlbumName":"若你碰到他","Category":1,"SuperExtName":"","mvdata":[{"typ":0,"trk":"3","hash":"A47449F5A958703234D366809858E67A","id":"758573"}],"OtherName":"","SongName":"红色高跟鞋","Res":{"PkgPrice":1,"Privilege":10,"PayType":3,"Price":200,"FailProcess":4},"AudioCdn":0,"SourceID":0,"SQDuration":206,"HQFileSize":8266389,"MixSongID":"32204446","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":206,"ResBitrate":1808,"HiFiQuality":3,"ResFileHash":"37618DBF581222015803057D2DBC759D","SingerId":[4247],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":152487,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"蔡健雅","ip_id":0,"id":4247}],"mvTotal":0,"MvHash":"A47449F5A958703234D366809858E67A","SuperFileSize":0,"Auxiliary":"《爱情呼叫转移2：爱情左右》电影主题曲","SQExtName":"flac","SQBitrate":985,"RankId":0,"PublishDate":"2009-08-19","HQFileHash":"1291C50F04BAF840B8AC209F9B824B97","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2180911,"Uploader":"","Duration":206,"SQFailProcess":4,"OriSongName":"红色高跟鞋","A320Privilege":10,"FileName":"蔡健雅 - 红色高跟鞋","ResFileSize":46712410,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1},{"SQFileHash":"C7978253821602F7A44C3FD6246BB4EA","PublishTime":"","Audioid":2554596,"SuperDuration":0,"OldCpy":0,"PublishAge":255,"HQBitrate":320,"PayType":3,"Accompany":1,"SingerName":"方大同","HQPrivilege":10,"TopicRemark":"","OriOtherName":"","ShowingFlag":0,"Source":"","SQFileSize":27091764,"AlbumAux":"","HQDuration":259,"Image":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20210901\/20210901172502839152.jpg","HQPayType":3,"vvid":"","M4aSize":0,"HeatLevel":6,"SQPkgPrice":1,"trans_param":{"cpy_grade":5,"classmap":{"attr0":234881032},"language":"国语","cpy_attr0":58727552,"musicpack_advance":1,"display":0,"display_rate":0,"cpy_level":1,"qualitymap":{"bits":"db4107ffff73fc035","attr0":2000666677,"attr1":1746993151},"pay_block_tpl":1,"hash_multitrack":"3A9B2662E53D17E3A2E6646705D76C04","cid":2456711,"ogg_128_filesize":2901046,"ogg_320_hash":"963BD93CABE3E6CD7884D33B980137D5","ipmap":{"attr0":2200130555906},"hash_offset":{"clip_hash":"237A1DD05495262A29AB86CC7F782F93","start_byte":0,"end_ms":60000,"end_byte":960121,"file_type":0,"start_ms":0,"offset_hash":"50D6C08129EFAF0328A99EB0E0002673"},"ogg_128_hash":"FC5E0E8B791641D2122864B26C4F2D9C","union_cover":"http:\/\/imge.kugou.com\/stdmusic\/{size}\/20210901\/20210901172502839152.jpg","ogg_320_filesize":9513459},"UploaderContent":"","FileSize":4146353,"IsOriginal":1,"FileHash":"0F7A79ADAAEEB6EA1DA3E19DD637FD73","FoldType":0,"Grp":[],"MvTrac":3,"ID":"32085003","Type":"audio","Bitrate":128,"SQPrice":200,"isPrepublish":0,"ExtName":"mp3","mvdata":[{"typ":0,"trk":"3","hash":"7234155E9346AA641A3728C311F830FB","id":"592521"}],"TopID":0,"AlbumPrivilege":10,"AlbumID":"965097","Category":1,"SuperExtName":"","AlbumName":"危险世界","OtherName":"","SongName":"特别的人","ASQPrivilege":10,"AudioCdn":0,"SourceID":0,"SQDuration":259,"HQFileSize":10365585,"MixSongID":"32085003","HQPkgPrice":1,"SQPayType":3,"SuperBitrate":0,"FailProcess":4,"HQPrice":200,"Suffix":"","HQFailProcess":4,"MvType":2,"ResDuration":0,"ResBitrate":0,"HiFiQuality":2,"ResFileHash":"","SingerId":[877],"SongLabel":"","HQExtName":"mp3","HasAlbum":1,"MatchFlag":0,"Scid":2554596,"SuperFileHash":"","QualityLevel":3,"Singers":[{"name":"方大同","ip_id":0,"id":877}],"mvTotal":0,"MvHash":"7234155E9346AA641A3728C311F830FB","SuperFileSize":0,"Auxiliary":"","SQExtName":"flac","SQBitrate":836,"RankId":0,"PublishDate":"2014-04-11","HQFileHash":"21A03867AAFE981DA8F0A7E5EEADD678","TopicUrl":"","TagDetails":[],"TagContent":"","Privilege":10,"PrepublishInfo":{"ReserveCount":0,"DisplayTime":"","Id":0,"PublishTime":""},"PkgPrice":1,"OwnerCount":2021410,"Uploader":"","Duration":259,"SQFailProcess":4,"OriSongName":"特别的人","A320Privilege":10,"FileName":"方大同 - 特别的人","ResFileSize":0,"SQPrivilege":10,"Price":200,"recommend_type":0,"Publish":1}],"sec_aggre":{},"aggregation":{},"size":20,"chinesecount":4,"searchfull":0,"allowerr":0,"correctionsubject":"","tab":"全部","AlgPath":"","sec_aggre_v2":[],"correctionforce":0,"istag":0,"from":0,"istagresult":1,"subjecttype":0,"sectag_info":{"is_sectag":0},"isshareresult":0},"status":1,"error_code":0}
```

---

# 4. 补充依赖接口（榜单详情）
首页榜单点击进入后加载歌曲用，脚本内原生接口
## 接口地址
```
http://mobilecdnbj.kugou.com/api/v3/rank/song
```
## 请求参数
```
version=9108
ranktype=0
plat=0
pagesize=100
area_code=1
page=1
volid=35050
rankid={上一步获取的榜单ID}
with_res_tag=0
```

---

# 5. 整体汇总表
| 模块 | 接口地址 | 请求方式 | 用途 |
|------|----------|----------|------|
| 热门榜单列表 | http://mobilecdnbj.kugou.com/api/v3/rank/list | GET | 首页榜单分类展示 |
| 推荐歌单 | http://mobilecdn.kugou.com/api/v3/search/special | GET | 首页歌单推荐板块 |
| 推荐歌曲 | https://songsearch.kugou.com/song_search_v2 | GET | 首页热门歌曲推荐 |
| 榜单歌曲详情 | http://mobilecdnbj.kugou.com/api/v3/rank/song | GET | 榜单内歌曲列表 |

