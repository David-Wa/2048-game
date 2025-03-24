#include "menubutton.h"

MenuButton::MenuButton(QString a) {
    fbutton=a;

}


QString MenuButton::readMenuButton() {
    emit InterfaceChanged();
    return fbutton;
}


