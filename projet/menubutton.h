#ifndef MENUBUTTON_H
#define MENUBUTTON_H

#include <QObject>

class Bouton : public QObject
{Q_OBJECT
    Q_PROPERTY (NOTIFY openMenu)
    Q_PROPERTY(QString  buttonName READ  getName WRITE setName NOTIFY nameChanged)
public:
   Bouton();
    void setName(const QString &a);
   QString getName();

private:
    Q_INVOKABLE void clicked();
    QString buttonName="bouton";
signals:
    void nameChanged();
    void openMenu();
};

#endif // MENUBUTTON_H
