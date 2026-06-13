#ifndef AUTOCLICKER_WINDOWS_H
#define AUTOCLICKER_WINDOWS_H

#define FFI_EXPORT_WINDOWS extern "C" __declspec(dllexport)

FFI_EXPORT_WINDOWS void startClicking(int msDelay, const char* mouseType);
FFI_EXPORT_WINDOWS void updateClickingDelay(int msDelay);
FFI_EXPORT_WINDOWS void stopClicking();

#endif
