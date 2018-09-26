#include "core/WindowManager.h"

WindowManager::WindowManager(void) :
    mWindow(nullptr)
{
    // Start curses mode and configure (enable coloring, disable line buffering
    // except for signal key combinations, pass arrows/F-keys, don't echo stdin)
    initscr();
    // start_color();
    cbreak();
    keypad(stdscr, TRUE);
    noecho();

    // Create the window.
    mWindow = new Window(0, 0);
}

WindowManager::~WindowManager(void)
{
    if (mWindow != nullptr) {
        delete mWindow;
    }
}
