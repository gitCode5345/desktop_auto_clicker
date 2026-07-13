# ⚡ ClickStorm — Desktop Auto Clicker

**ClickStorm** is a fast, lightweight auto clicker for **Windows** and **macOS**, built with Flutter and a native C++ engine for precise, low-latency clicking. Flexible interval control, a delayed start, and a global hotkey give you everything you need to automate repetitive clicks.

## ✨ Features

- 🖱 **Mouse button selection** — left or right button
- ⏱ **Adjustable click interval** — 10 to 1000 ms (via slider or manual input)
- ⏳ **Delayed start** — start clicking after a set countdown (0–60 s)
- ⌨️ **Global hotkey `F6`** — start/stop the clicker from anywhere, even when the app window isn't focused
- 📊 **Live CPS graph** (clicks per second) — real-time visualization of clicking activity
- 🎯 **Native performance** — clicking is driven through an FFI bridge to a native module (C++), separate implementations for Windows and macOS
- 🖥 **Responsive UI** — adapts cleanly to both wide and narrow windows

## 🖼 Architecture

The project follows **Clean Architecture** principles with clear layer separation:

```
lib/src/
├── core/                      # Shared constants, enums, themes, base usecases
├── configs/injector/          # Global Dependency Injection setup (get_it)
└── features/main_page/
    ├── domain/                # Entities, repository interfaces, usecases
    │   ├── entities/          # ButtonClickConfigEntity
    │   ├── repository/        # ClickerRepository (interface)
    │   └── usecases/          # StartClicking / StopClicking / UpdateClickingMs
    ├── data/                  # Repository implementation + FFI data source
    │   ├── data_sources/ffi/  # RunClickerService (calls into the native library)
    │   └── repository/        # ClickerRepositoryImpl
    ├── di/                    # Feature-level DI registration (MainPageDependency)
    └── presentation/          # BLoC, pages and UI widgets
        ├── bloc/clicker/      # ClickerBloc (clicker state, countdown timer)
        ├── models/            # Presentation-only models (e.g. nav destination items)
        ├── pages/             # MainPage (UI layout, BLoC wiring)
        └── widgets/           # Slider, dropdown, CPS graph, start/stop buttons
```

The actual clicking logic lives in native code and is invoked via `dart:ffi`:

```
native_autoclicker/
├── windows_autoclicker/   # C++ implementation using the WinAPI SendInput
└── macos_autoclicker/     # C++ implementation for macOS
```

## 🛠 Tech Stack

- **[Flutter](https://flutter.dev)** (Dart SDK `^3.9.2`) — cross-platform UI
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)** — state management
- **[get_it](https://pub.dev/packages/get_it)** — dependency injection
- **[hotkey_manager](https://pub.dev/packages/hotkey_manager)** — global hotkeys
- **[ffi](https://pub.dev/packages/ffi)** — Dart ↔ native C++ interop
- **[equatable](https://pub.dev/packages/equatable)** — value equality
- C++ — native click engine

## 🚀 Getting Started

### Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) with desktop support enabled
- Windows 10+ or macOS
- For Windows builds: Visual Studio with the "Desktop development with C++" workload
- For macOS builds: Xcode

### Steps

```bash
# Clone the repository
git clone https://github.com/gitCode5345/desktop_auto_clicker.git
cd desktop_auto_clicker

# Install dependencies
flutter pub get

# Run in development mode
flutter run -d windows   # or -d macos
```

### Release build

```bash
flutter build windows --release
# or
flutter build macos --release
```

The compiled app will be available in `build/windows/x64/runner/Release/` or `build/macos/Build/Products/Release/`.

## 🎮 Usage

1. Select the mouse button to simulate (left / right).
2. Set the click interval (10–1000 ms) using the slider or by typing a value.
3. Optionally enable **"Delayed Start"** and set the countdown in seconds.
4. Press **"Start"** or use the global hotkey **`F6`**.
5. Stop the clicker with the **"Stop"** button or by pressing **`F6`** again — even if the app window isn't focused.

## 📁 Project Structure (top level)

```
├── lib/                    # Dart / Flutter application code
├── native_autoclicker/     # Native C++ code (Windows / macOS)
├── assets/                 # Fonts, icons, clicker resources
├── windows/                # Windows platform-specific code (CMake, runner)
├── macos/                  # macOS platform-specific code (Xcode project)
└── pubspec.yaml            # Flutter dependencies and configuration
```

## ⚠️ Disclaimer

This tool is intended for legitimate use: testing, automating repetitive tasks, and personal productivity. Using an auto clicker may violate the terms of service of some applications or online games (e.g. it could result in a ban) — use it at your own discretion and risk.
