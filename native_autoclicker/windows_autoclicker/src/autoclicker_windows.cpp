#include "../include/autoclicker_windows.h"

#include <thread>
#include <atomic>
#include <chrono>
#include <string>

#include <windows.h>

std::atomic<bool> is_running(false);
std::atomic<int> current_delay(0);

std::thread click_thread;

struct MouseEventTypeWindows
{
    DWORD tag_input;
    DWORD click_down;
    DWORD click_up;
};

void startClickingLoop(MouseEventTypeWindows button_for_click)
{
    while (is_running)
    {
        INPUT inputs[2] = {};

        inputs[0].type = button_for_click.tag_input;
        inputs[0].mi.dwFlags = button_for_click.click_down;

        inputs[1].type = button_for_click.tag_input;
        inputs[1].mi.dwFlags = button_for_click.click_up;

        SendInput(2, inputs, sizeof(INPUT));

        std::this_thread::sleep_for(std::chrono::milliseconds(current_delay.load()));
    }
}

MouseEventTypeWindows getButton(const std::string type)
{
    if (type == "left_mouse_button")
        return {INPUT_MOUSE, MOUSEEVENTF_LEFTDOWN, MOUSEEVENTF_LEFTUP};
    else if (type == "right_mouse_button")
        return {INPUT_MOUSE, MOUSEEVENTF_RIGHTDOWN, MOUSEEVENTF_RIGHTUP};
    else
        return {INPUT_MOUSE, MOUSEEVENTF_LEFTDOWN, MOUSEEVENTF_LEFTUP};
}

FFI_EXPORT_WINDOWS void startClicking(int msDelay, const char* button)
{
    std::string type = std::string(button);

    if (is_running) 
        return;
    
    current_delay = msDelay;
    MouseEventTypeWindows mouse_event_button = getButton(type);
    
    is_running = true;

    click_thread = std::thread(startClickingLoop, mouse_event_button);
}

FFI_EXPORT_WINDOWS void updateClickingDelay(int msDelay)
{
    current_delay = msDelay;
}

FFI_EXPORT_WINDOWS void stopClicking()
{
    if (!is_running)
        return;

    is_running = false;
    
    if (click_thread.joinable())
        click_thread.join();
}

FFI_EXPORT_WINDOWS bool isClicking()
{
    return is_running;
}
