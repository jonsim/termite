/**
 *  \file   Panel.h
 *  \author Jonathan Simmonds
 *  \brief  TODO
 */
#ifndef _PANEL_H
#define _PANEL_H

#include <string>

#include <ncurses.h>
#include <stdint.h>


#include "Window.h"


namespace termite {

/**
 * \brief TODO
 */
class Panel
{
private:
    /** The ncurses window to draw into. */
    WINDOW* mWindow;
    /** The width of the window in characters. */
    const uint16_t mWidth;
    /** The height of the window in characters. */
    const uint16_t mHeight;

    std::string mText;

public:
    /**
     * \brief  Window constructor.
     *
     * \throws WMException
     */
    explicit Panel(const Window& parent);

    /**
     *  \brief  Window destructor.
     */
    virtual ~Panel(void);

    const std::string& getText(void) const;

    void setText(const std::string& text);
};

}

#endif