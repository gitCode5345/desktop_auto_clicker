import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';

typedef StartClickingFuncNative = ffi.Void Function(ffi.Int msDelay, ffi.Pointer<Utf8> mouseType);
typedef StartClickingFuncDart = void Function(int msDelay, ffi.Pointer<Utf8> mouseType);

typedef UpdateDelayFuncNative = ffi.Void Function(ffi.Int msDelay);
typedef UpdateDelayFuncDart = void Function(int msDelay);

typedef StopClickingFuncNative = ffi.Void Function();
typedef StopClickingFuncDart = void Function();

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

  bool _isInitialized = false;

  void _init() {
    _dylib = ffi.DynamicLibrary.open(_getLibPath());

    _startClickingFunc = _dylib.lookupFunction<StartClickingFuncNative, StartClickingFuncDart>('startClicking');
    _updateDelayFunc = _dylib.lookupFunction<UpdateDelayFuncNative, UpdateDelayFuncDart>('updateClickingDelay');
    _stopClickingFunc = _dylib.lookupFunction<StopClickingFuncNative, StopClickingFuncDart>('stopClicking');
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

  void startClicking(int msDelay, String button) {
    if (!_isInitialized) {
      _init();
      _isInitialized = true;
    }

    _startClickingFunc(msDelay, button.toNativeUtf8());
  }

  void updateDelay(int msDelay) {
    _updateDelayFunc(msDelay);
  }

  void stopClicking() {
    _stopClickingFunc();
  }
}
