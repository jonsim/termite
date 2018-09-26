#include "core/Panel.h"

using namespace termite;


Panel::Panel(const Window& parent) :
    mWidth(0),
    mHeight(0),
    mText()
{
}

Panel::~Panel(void)
{
}

const std::string& Panel::getText(void) const
{
    return mText;
}

void Panel::setText(const std::string& text)
{
    mText = text;
}
