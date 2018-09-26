#include "core/Window.h"

#include <iostream> // std::ios
#include <sstream>  // std::ostringstream

#include "core/WMException.h"

using namespace termite;


Window::Window(uint16_t width, uint16_t height) :
    mWindow(nullptr),
    mWidth(width),
    mHeight(height)
{
    // Check the screen is big enough.
    int rows, cols;
    getmaxyx(stdscr, rows, cols);
    if (width == 0) {
        width = cols;
    } else if (cols < width) {
        // Exit curses mode and throw.
        endwin();

        std::ostringstream oss;
        oss << "Console not wide enough. Must have at least " << width
            << " columns (only has " << cols << ")." << std::endl;
        throw WMException(oss.str());
    }
    if (height == 0) {
        height = rows;
    } else if (rows < height) {
        // Exit curses mode and throw.
        endwin();

        std::ostringstream oss;
        oss << "Console not tall enough. Must have at least " << height
            << " columns (only has " << rows << ")." << std::endl;
        throw WMException(oss.str());
    }

    // Create and initialise the grid window.
    mWindow = newwin(height, width, 0, 0);
    wattron(mWindow, COLOR_PAIR(2));
    box(mWindow, 0, 0);
    wattroff(mWindow, COLOR_PAIR(2));

    // Finally, draw the initial configuration (always refresh bottom-up).
    wrefresh(stdscr);
    wrefresh(mWindow);
}

Window::~Window(void)
{
    // Exit curses mode.
    endwin();
}

void Window::redraw(void) const
{
    wrefresh(mWindow);
}