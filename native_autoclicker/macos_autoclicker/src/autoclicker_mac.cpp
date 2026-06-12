#include "../include/autoclicker_mac.h"

#include <thread>
#include <atomic>
#include <chrono>
#include <string>

#include <ApplicationServices/ApplicationServices.h>

std::atomic<bool> is_running(false);
std::atomic<bool> is_stopped(false);
std::atomic<int> current_delay(0);

std::thread click_thread;

struct MouseEventTypeMac {
    CGMouseButton button;
    CGEventType click_down;
    CGEventType click_up;
};

void startClickingLoop(MouseEventTypeMac event_type) {
    while (!is_stopped) {
        CGEventRef event = CGEventCreate(NULL);
        CGPoint cursorPos = CGEventGetLocation(event);
        CFRelease(event);

        CGEventRef click_down = CGEventCreateMouseEvent(NULL, event_type.click_down, cursorPos, event_type.button);
        CGEventRef click_up = CGEventCreateMouseEvent(NULL, event_type.click_up, cursorPos, event_type.button);

        CGEventPost(kCGHIDEventTap, click_down);
        CGEventPost(kCGHIDEventTap, click_up);

        CFRelease(click_down);
        CFRelease(click_up);

        std::this_thread::sleep_for(std::chrono::milliseconds(current_delay.load()));
    }
}

MouseEventTypeMac getMouseEventType(const char* mouseType) {
    std::string type(mouseType);

    if (type == "left") {
        return {kCGMouseButtonLeft, kCGEventLeftMouseDown, kCGEventLeftMouseUp};
    } else if (type == "right") {
        return {kCGMouseButtonRight, kCGEventRightMouseDown, kCGEventRightMouseUp};
    } else {
        return {kCGMouseButtonLeft, kCGEventLeftMouseDown, kCGEventLeftMouseUp};
    }
}

FFI_EXPORT void startClicking(int msDelay, const char* mouseType) {
    if (is_running) {
        return;
    }

    current_delay = msDelay;
    MouseEventTypeMac event_type = getMouseEventType(mouseType);

    is_running = true;
    is_stopped = false;
    click_thread = std::thread(startClickingLoop, event_type);
}

FFI_EXPORT void updateClickingDelay(int msDelay)
{
    current_delay = msDelay;
}

FFI_EXPORT void stopClicking() {
    if (!is_running) {
        return;
    }

    is_stopped = true;
    if (click_thread.joinable()) {
        click_thread.join();
    }
    is_running = false;
}
