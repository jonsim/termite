#include "core/WindowManager.h"

#include <chrono>   // milliseconds, high_resolution_clock
#include <thread>   // thread, sleep_until

#include "core/Window.h"

using namespace termite;



/**
 *  \brief  A loop which runs indefinitely at a fixed interval until some
 *          condition is no longer met.
 *  \param  ms_interval         The number of miliseconds between loop executions.
 *  \param  continue_condition  Pointer to the condition which must be met to
 *              continue execution.
 *  \param  component           Pointer to the core component to update each
                time round the loop.
 *  \param  state               Pointer to the state to pass to the component on
                update.
 */
void redraw_loop(uint32_t ms_interval, bool* continue_condition, IDrawable* drawable)
{
    using namespace std::chrono;
    milliseconds update_interval(ms_interval);
    high_resolution_clock::time_point last_update = high_resolution_clock::now();

    while (*continue_condition)
    {
        // Redraw.
        drawable->redraw();

        // Wait for next update.
        high_resolution_clock::time_point next_update = last_update + update_interval;
        std::this_thread::sleep_until(next_update);
        last_update = next_update;
    }
}


WindowManager::WindowManager(void) :
    mUIThreadRunning(false),
    mUIThread(nullptr),
    mCurrentWindow(nullptr)
{
    // Start curses mode and configure (enable coloring, disable line buffering
    // except for signal key combinations, pass arrows/F-keys, don't echo stdin)
    initscr();
    // start_color();
    cbreak();
    keypad(stdscr, TRUE);
    noecho();

    // Define color pairings.
    init_pair(1, COLOR_RED, COLOR_BLACK);
    init_pair(2, COLOR_CYAN, COLOR_BLACK);
    init_pair(3, COLOR_BLACK, COLOR_WHITE);

    // Start the UI thread.
    mUIThreadRunning = true;
    mUIThread = new std::thread(redraw_loop, 1000u / UI_REFRESH_PER_SECOND,
            &mUIThreadRunning, (IDrawable*) this);
}

WindowManager::~WindowManager(void)
{
    // Stop the UI thread.
    mUIThreadRunning = false;
    mUIThread->join();
    delete mUIThread;

    for (Window* window : mWindows) {
        delete window;
    }
}

void WindowManager::redraw(void) const
{
    if (mCurrentWindow != nullptr) {
        mCurrentWindow->redraw();
    }
}

Window* WindowManager::createWindow(uint16_t width, uint16_t height,
        bool createInBackground)
{
    Window* window = new Window(width, height);
    mWindows.push_back(window);

    if (!createInBackground) {
        mCurrentWindow = window;
    }

    return window;
}

Window* WindowManager::getCurrentWindow(void) const
{
    return mCurrentWindow;
}
