import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';
import 'package:ffi/ffi.dart';

typedef StartClickingFuncNative = ffi.Void Function(ffi.Int msDelay, ffi.Pointer<Utf8> mouseType);
typedef StartClickingFuncDart = void Function(int msDelay, ffi.Pointer<Utf8> mouseType);

typedef UpdateDelayFuncNative = ffi.Void Function(ffi.Int msDelay);
typedef UpdateDelayFuncDart = void Function(int msDelay);

typedef StopClickingFuncNative = ffi.Void Function();
typedef StopClickingFuncDart = void Function();

typedef IsClickingFuncNative = ffi.Bool Function();
typedef IsClickingFuncDart = bool Function();

class RunClickerService {
  RunClickerService._internal();

  static final RunClickerService _instance = RunClickerService._internal();

  factory RunClickerService() {
    return _instance;
  }

  late final ffi.DynamicLibrary _dylib;

  late final StartClickingFuncDart _startClickingFunc;
  late final UpdateDelayFuncDart _updateDelayFunc;
  late final StopClickingFuncDart _stopClickingFunc;
  late final IsClickingFuncDart _isClickingFunc;

  bool _isInitialized = false;

  void _init() {
    _dylib = ffi.DynamicLibrary.open(_getLibPath());

    _startClickingFunc = _dylib.lookupFunction<StartClickingFuncNative, StartClickingFuncDart>('startClicking');
    _updateDelayFunc = _dylib.lookupFunction<UpdateDelayFuncNative, UpdateDelayFuncDart>('updateClickingDelay');
    _stopClickingFunc = _dylib.lookupFunction<StopClickingFuncNative, StopClickingFuncDart>('stopClicking');
    _isClickingFunc = _dylib.lookupFunction<IsClickingFuncNative, IsClickingFuncDart>('isClicking');
  }

  String _getLibPath() {
    final executableUri = Uri.file(Platform.resolvedExecutable);

    switch (Platform.operatingSystem) {
      case 'macos':
        final libUri = executableUri.resolve('../Frameworks/App.framework/Resources/flutter_assets/assets/clicker/libautoclicker.dylib');
        return libUri.toFilePath();
      case 'windows':
        final libUri = executableUri.resolve('data/flutter_assets/assets/clicker/libautoclicker.dll');
        return libUri.toFilePath();
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  bool _checkInitialized() {
    if (!_isInitialized) {
      _init();
      _isInitialized = true;
    }
    return _isInitialized;
  }

  void startClicking(ButtonClickConfigEntity button) {
    final buttonPointer = button.button.name.toNativeUtf8();
    final buttonClickingDelay = button.delayMs!;
    try {
      _checkInitialized();
      _startClickingFunc(buttonClickingDelay, buttonPointer);
    } finally {
      calloc.free(buttonPointer);
    }
  }

  void updateClickingMs(ButtonClickConfigEntity button) {
    _checkInitialized();
    final msDelay = button.delayMs!;
    _updateDelayFunc(msDelay);
  }

  void stopClicking() {
    _checkInitialized();
    _stopClickingFunc();
  }

  bool isClicking() {
    _checkInitialized();
    return _isClickingFunc();
  }
}
