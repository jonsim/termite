/**
 *  \file   Window.h
 *  \author Jonathan Simmonds
 *  \brief  TODO
 */
#ifndef _WINDOW_H
#define _WINDOW_H

#include <ncurses.h>
#include <stdint.h>

#include "WMException.h"

/**
 * \brief TODO
 */
class Window
{
private:
    /** The ncurses window to draw into. */
    WINDOW* mWindow;
    /** The width of the window in characters. */
    const uint16_t mWidth;
    /** The height of the window in characters. */
    const uint16_t mHeight;

public:
    /**
     * \brief  Window constructor.
     *
     * \throws WMException
     */
    explicit Window(uint16_t width, uint16_t height);

    /**
     *  \brief  Window destructor.
     */
    virtual ~Window(void);
};

#endif