#include "menubutton.h"

Bouton::Bouton() {
    QString fBouton="bouton";

}

void Bouton::clicked() {
    emit openMenu();
}
