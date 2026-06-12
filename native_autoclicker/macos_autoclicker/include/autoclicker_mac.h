#ifndef AUTOCLICKER_MAC_H
#define AUTOCLICKER_MAC_H

#define FFI_EXPORT extern "C" __attribute__((visibility("default")))

FFI_EXPORT void start_clicking(int msDelay, const char* mouseType);
FFI_EXPORT void update_delay(int msDelay);
FFI_EXPORT void stop_clicking();

#endif // AUTOCLICKER_MAC_H
