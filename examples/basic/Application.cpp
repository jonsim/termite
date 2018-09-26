#include <stdio.h>
#include <unistd.h>

#include "core/Panel.h"
#include "core/Window.h"
#include "core/WindowManager.h"

int main()
{
    printf("hello world\n");

    termite::WindowManager winMgr;
    termite::Window* window = winMgr.createWindow(0, 0);
    termite::Panel panel(*window);
    panel.setText("hello world");
    sleep(5);

    return 0;
}