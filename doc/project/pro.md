# Agamemnon

## 项目结构

AgamemnonSrc/                              ← Godot 项目根
│
├── project.godot                          # 项目主配置
├── icon.svg / icon.svg.import
├── .editorconfig / .gitattributes / .gitignore
│
├── 📁 scenes/                             #  Godot 场景（.tscn）
│   ├── main_menu.tscn
│   ├── lobby.tscn
│   ├── auction_room.tscn
│   └── ui_components/
│       ├── bid_button.tscn
│       ├── countdown_bar.tscn
│       └── price_display.tscn
│
├── 📁 scripts/                            #  GDScript（.gd）
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
├── 📁 src/                                #  C++ GDExtension 源码
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
├── 📁 bin/                                # C++ 编译产物
│   ├── auction_king.gdextension           # GDExtension 配置
│   ├── linux/
│   │   ├── libauction_king.debug.so
│   │   └── libauction_king.release.so
│   └── windows/
│       ├── auction_king.debug.dll
│       └── auction_king.release.dll
│
├── 📁 godot-cpp/                          #  Godot C++ 绑定（git submodule）
│   └── （Godot 官方提供的 C++ 头文件）
│
├── 📁 assets/                             # 美术/音效资源
│   ├── sprites/
│   ├── sounds/
│   └── fonts/
│
├── 📁 servers/                            #  独立的拍卖服务器
│   ├── CMakeLists.txt
│   ├── main.cpp
│   ├── auction_server.h / .cpp
│   ├── room_manager.h / .cpp
│   └── README.md
│
└── 📁 docs/                               # 文档
    ├── architecture.md
    └── network_protocol.md