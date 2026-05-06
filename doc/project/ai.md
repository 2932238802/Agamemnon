# Agamemnon

## 空间树
AuctionScene (Node2D)
├── Background           # 拍卖厅背景
├── ItemDisplay          # 拍品展示（旋转/特效）
├── UI (Control)
│   ├── PriceLabel       # 当前价格（带跳动动画）
│   ├── CountdownBar     # 倒计时条
│   ├── BidPanel
│   │   ├── +100 Button
│   │   ├── +500 Button
│   │   └── CustomBid Input
│   ├── BidderList       # 竞拍者头像 + 状态
│   └── BidHistory       # 出价滚动记录
└── Network (Node)
    └── AuctionClient    # 网络层

## 项目结构
bid-king/
├── project.godot                    # 项目配置
├── scenes/
│   ├── main_menu.tscn               # 主菜单
│   ├── lobby.tscn                   # 大厅（拍卖场列表）
│   ├── auction_room.tscn            # 拍卖主场景 ★
│   ├── result.tscn                  # 竞拍结果
│   └── ui_components/               # 可复用 UI 组件
│       ├── bid_button.tscn          # 出价按钮
│       ├── countdown_bar.tscn       # 倒计时条
│       ├── price_display.tscn       # 价格展示
│       ├── bid_history.tscn         # 出价记录
│       └── player_avatar.tscn       # 玩家头像
├── scripts/                         # GDScript
│   ├── auction/
│   │   ├── auction_manager.gd       # 拍卖核心逻辑
│   │   ├── auction_room_ui.gd       # 拍卖房间 UI
│   │   └── countdown.gd            # 倒计时控制器
│   ├── network/
│   │   ├── network_manager.gd       # 网络管理器
│   │   └── message_handler.gd       # 消息解析
│   ├── steam/
│   │   └── steam_manager.gd         # Steam API
│   └── global/
│       ├── game_state.gd            # 全局状态（单例）
│       └── theme.gd                 # 主题/颜色
├── src/                             # C++ GDExtension ★
│   ├── CMakeLists.txt
│   ├── auction_engine.h / .cpp      # 拍卖引擎
│   ├── net_client.h / .cpp          # 网络客户端（ENet）
│   └── register_types.cpp           # 注册到 Godot
├── assets/
│   ├── sprites/                     # 图片素材
│   ├── sounds/                      # 音效
│   └── fonts/                       # 字体
└── servers/                         # 独立的拍卖服务器
    ├── CMakeLists.txt
    ├── server_main.cpp
    ├── room_manager.h / .cpp
    └── auction_server.h / .cpp


## 文件理解
.tscn  =  场景文件 (Scene)          ≈ Qt 的 .ui 文件
.gd    =  脚本文件 (GDScript)       ≈ Qt 的 .cpp 文件
.tscn 描述"长什么样"，.gd 描述"怎么动"
一个 .tscn 可以嵌另一个 .tscn（重要！）
.gd 是附加到某个节点的脚本，给那个节点"赋予行为"

维度	            .tscn	                .gd
本质	            节点树描述	            行为逻辑
文件格式	        文本（类 INI）	        GDScript 源码
Qt 类比	            .ui XML	                .cpp 源文件
编辑方式	        Godot 编辑器拖拽	    代码编辑器手写
运行时行为	        加载 → 实例化节点	    被节点调用 → 执行逻辑
可否单独存在	    可以（无脚本的纯场景）	    可以（工具类脚本）
Git diff 友好	    ✅ 文本对比	            ✅ 代码对比

## ai 项目结构推荐
AgamemnonSrc/                              ← Godot 项目根
│
├── project.godot                          # 项目主配置
├── icon.svg / icon.svg.import
├── .editorconfig / .gitattributes / .gitignore
│
├── 📁 scenes/                             # ⭐ Godot 场景（.tscn）
│   ├── main_menu.tscn
│   ├── lobby.tscn
│   ├── auction_room.tscn
│   └── ui_components/
│       ├── bid_button.tscn
│       ├── countdown_bar.tscn
│       └── price_display.tscn
│
├── 📁 scripts/                            # ⭐ GDScript（.gd）
│   ├── ui/
│   │   ├── auction_room_ui.gd
│   │   ├── bid_button.gd
│   │   └── countdown_bar.gd
│   ├── network/
│   │   └── network_manager.gd
│   ├── steam/
│   │   └── steam_manager.gd
│   └── global/
│       ├── game_state.gd                  # 全局单例
│       └── theme.gd
│
├── 📁 src/                                # ⭐⭐⭐ C++ GDExtension 源码
│   ├── CMakeLists.txt
│   ├── register_types.h / .cpp            # 注册类到 Godot
│   │
│   ├── auction/                           # 拍卖引擎核心
│   │   ├── auction_engine.h / .cpp        # 主引擎
│   │   ├── bid_validator.h / .cpp         # 出价验证
│   │   └── auction_room.h / .cpp          # 拍卖房间
│   │
│   ├── network/                           # 网络层
│   │   ├── net_client.h / .cpp            # ENet 客户端
│   │   └── message_codec.h / .cpp         # 消息编解码
│   │
│   └── utils/
│       └── debug_log.h / .cpp
│
├── 📁 bin/                                # ⭐ C++ 编译产物（重要！）
│   ├── auction_king.gdextension           # GDExtension 配置
│   ├── linux/
│   │   ├── libauction_king.debug.so
│   │   └── libauction_king.release.so
│   └── windows/
│       ├── auction_king.debug.dll
│       └── auction_king.release.dll
│
├── 📁 godot-cpp/                          # ⭐ Godot C++ 绑定（git submodule）
│   └── （Godot 官方提供的 C++ 头文件）
│
├── 📁 assets/                             # 美术/音效资源
│   ├── sprites/
│   ├── sounds/
│   └── fonts/
│
├── 📁 servers/                            # ⭐ 独立的拍卖服务器
│   ├── CMakeLists.txt
│   ├── main.cpp
│   ├── auction_server.h / .cpp
│   ├── room_manager.h / .cpp
│   └── README.md
│
└── 📁 docs/                               # 文档
    ├── architecture.md
    └── network_protocol.md