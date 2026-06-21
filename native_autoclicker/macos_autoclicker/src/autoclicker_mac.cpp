#include "../include/autoclicker_mac.h"

#include <thread>
#include <atomic>
#include <chrono>
#include <string>

#include <ApplicationServices/ApplicationServices.h>

std::atomic<bool> is_running(false);
std::atomic<int> current_delay(0);

std::thread click_thread;

struct MouseEventTypeMac
{
    CGMouseButton button;
    CGEventType click_down;
    CGEventType click_up;
};

void startClickingLoop(MouseEventTypeMac button_for_click) 
{
    while (is_running)
    {
        CGEventRef event = CGEventCreate(NULL);
        CGPoint cursorPos = CGEventGetLocation(event);
        CFRelease(event);

        CGEventRef click_down = CGEventCreateMouseEvent(NULL, button_for_click.click_down, cursorPos, button_for_click.button);
        CGEventRef click_up = CGEventCreateMouseEvent(NULL, button_for_click.click_up, cursorPos, button_for_click.button);

        CGEventPost(kCGHIDEventTap, click_down);
        CGEventPost(kCGHIDEventTap, click_up);

        CFRelease(click_down);
        CFRelease(click_up);

        std::this_thread::sleep_for(std::chrono::milliseconds(current_delay.load()));
    }
}

MouseEventTypeMac getButton(const std::string type) 
{
    if (type == "left_mouse_button") 
        return {kCGMouseButtonLeft, kCGEventLeftMouseDown, kCGEventLeftMouseUp};
    else if (type == "right_mouse_button") 
        return {kCGMouseButtonRight, kCGEventRightMouseDown, kCGEventRightMouseUp};
    else 
        return {kCGMouseButtonLeft, kCGEventLeftMouseDown, kCGEventLeftMouseUp};
}

FFI_EXPORT_MAC void startClicking(int msDelay, const char* button)
{
    std::string type(button);

    if (is_running) 
        return;

    current_delay = msDelay;
    MouseEventTypeMac mouse_event_button = getButton(type);

    is_running = true;
    
    click_thread = std::thread(startClickingLoop, mouse_event_button);
}

FFI_EXPORT_MAC void updateClickingDelay(int msDelay)
{
    current_delay = msDelay;
}

FFI_EXPORT_MAC void stopClicking()
{
    if (!is_running)
        return;

    is_running = false;

    if (click_thread.joinable())
        click_thread.join();
}

FFI_EXPORT_MAC bool isClicking()
{
    return is_running;
}
