#ifndef MENUBUTTON_H
#define MENUBUTTON_H

#include <QObject>



class MenuButton: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString buttonQML READ readMenuButton NOTIFY InterfaceChanged)
public:
    MenuButton(QString a="Bouton");
private:
    QString fbutton;
    QString readMenuButton();
signals:
    void InterfaceChanged();
};

#endif // MENUBUTTON_H

