#ifndef AUTOCLICKER_MAC_H
#define AUTOCLICKER_MAC_H

#define FFI_EXPORT_MAC extern "C" __attribute__((visibility("default")))

FFI_EXPORT_MAC void startClicking(int msDelay, const char* button);
FFI_EXPORT_MAC void updateClickingDelay(int msDelay);
FFI_EXPORT_MAC void stopClicking();

#endif // AUTOCLICKER_MAC_H
