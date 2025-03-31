#include "menubutton.h"


Bouton::Bouton() {}


void Bouton::clicked() {

 emit openMenu();  // Émission du signal

}


void Bouton::setName(const QString &a){
    buttonName=a;
    emit nameChanged();
}

QString Bouton::getName()
{return buttonName;
}


