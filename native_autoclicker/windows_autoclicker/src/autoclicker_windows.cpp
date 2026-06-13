#include "autoclicker_windows.h"

#include <thread>
#include <atomic>
#include <chrono>
#include <string>

#include <windows.h>

std::atomic<bool> is_running(false);
std::atomic<bool> is_stopped(false);
std::atomic<int> current_delay(0);

std::thread click_thread;

void startClickingLoop()
{
    while (!is_stopped)
    {
        INPUT inputs[2] = {};

        inputs[0].type = INPUT_MOUSE;
        inputs[0].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;

        inputs[1].type = INPUT_MOUSE;
        inputs[1].mi.dwFlags = MOUSEEVENTF_LEFTUP;

        SendInput(2, inputs, sizeof(INPUT));

        std::this_thread::sleep_for(std::chrono::milliseconds(current_delay.load()));
    }
}

FFI_EXPORT_WINDOWS void startClicking(int msDelay, const char* mouseType)
{
    std::string type = std::string(mouseType);

    if (is_running) 
        return;

    is_running = true;
    is_stopped = false;
    current_delay = msDelay;
    // TODO: make a structure for windows buttons
    click_thread = std::thread(startClickingLoop);
}

FFI_EXPORT_WINDOWS void updateClickingDelay(int msDelay)
{
    current_delay = msDelay;
}

FFI_EXPORT_WINDOWS void stopClicking()
{
    if (!is_running)
        return;
    
    is_stopped = true;

    if (click_thread.joinable())
        click_thread.join();
    
    is_running = false;
}
