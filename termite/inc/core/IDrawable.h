/**
 *  \file   Drawable.h
 *  \author Jonathan Simmonds
 *  \brief  TODO
 */
#ifndef _DRAWABLE_H
#define _DRAWABLE_H


namespace termite {

/**
 * \brief TODO
 */
class IDrawable
{
public:
    /**
     * \brief Redraw this drawable.
     */
    virtual void redraw(void) const = 0;
};

}

#endif