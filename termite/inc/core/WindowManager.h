/**
 *  \file   WindowManager.h
 *  \author Jonathan Simmonds
 *  \brief  TODO
 */
#ifndef _WINDOW_MANAGER_H
#define _WINDOW_MANAGER_H

#include <thread>
#include <vector>

#include "IDrawable.h"
#include "Window.h"


/// Number of UI redraws per second.
#define UI_REFRESH_PER_SECOND 30


namespace termite {

/**
 * \brief TODO
 */
class WindowManager : IDrawable
{
private:
    /** Whether or not the UI thread is running. */
    bool mUIThreadRunning;
    /** The thread on which the UI is updated. */
    std::thread* mUIThread;
    /** The window under the control of this window manager. */
    std::vector<Window*> mWindows;

    Window* mCurrentWindow;

public:
    /**
     *  \brief  WindowManager constructor.
     */
    explicit WindowManager(void);

    /**
     *  \brief  WindowManager destructor.
     */
    virtual ~WindowManager(void);

    virtual void redraw(void) const;

    Window* createWindow(uint16_t width, uint16_t height,
            bool createInBackground = false);

    Window* getCurrentWindow(void) const;
};

}

#endif