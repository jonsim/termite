/**
 *  \file   WindowManager.h
 *  \author Jonathan Simmonds
 *  \brief  TODO
 */
#ifndef _WINDOW_MANAGER_H
#define _WINDOW_MANAGER_H

#include <vector>

#include "Window.h"

/**
 * \brief TODO
 */
class WindowManager
{
private:
    /** The window under the control of this window manager. */
    Window* mWindow;

public:
    /**
     *  \brief  WindowManager constructor.
     */
    explicit WindowManager(void);

    /**
     *  \brief  WindowManager destructor.
     */
    virtual ~WindowManager(void);
};

#endif