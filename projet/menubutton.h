#ifndef MENUBUTTON_H
#define MENUBUTTON_H

#include <QObject>

class Bouton : public QObject
{Q_OBJECT
    Q_PROPERTY (NOTIFY openMenu)
public:
    Bouton();
private:
    QString fBouton;
    Q_INVOKABLE void clicked();
signals:
    void openMenu();
};

#endif // MENUBUTTON_H
