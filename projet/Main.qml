import QtQuick
import QtQuick.Window

Window {
    id: mainWindow
    width: 480
    height: 640
    visible: true
    title: "2048"
    color: "#FAF8EF"  // Couleur de fond similaire au jeu 2048 original

    // Point d'entrée de l'application, charge la fenêtre principale du jeu
    GameWindow {
        anchors.fill: parent
    }
}
