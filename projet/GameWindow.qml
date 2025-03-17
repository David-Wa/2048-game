import QtQuick
import QtQuick.Controls

Item {
    id: gameWindow

    // Propriété pour suivre l'état actuel du jeu (menu, jeu en cours, etc.)
    property string currentScreen: "menu"

    // Chargeur pour gérer les différents écrans
    Loader {
        id: screenLoader
        anchors.fill: parent
        // source: getScreenSource()  // Commentez cette ligne
        source: "MainMenu.qml"  // Prévisualisez directement un écran
    }

    // Fonction pour déterminer quel écran charger
    function getScreenSource() {
        switch(currentScreen) {
            case "menu":
                return "screens/MainMenu.qml";
            case "game":
                return "screens/GameScreen.qml";
            case "options":
                return "screens/OptionsScreen.qml";
            case "about":
                return "screens/AboutScreen.qml";
            case "gameOver":
                return "screens/GameOverScreen.qml";
            default:
                return "screens/MainMenu.qml";
        }
    }

    // Fonctions pour changer d'écran
    function showMainMenu() {
        currentScreen = "menu";
    }

    function startGame() {
        currentScreen = "game";
    }

    function showOptions() {
        currentScreen = "options";
    }

    function showAbout() {
        currentScreen = "about";
    }

    function gameOver() {
        currentScreen = "gameOver";
    }

    // Démarrer avec le menu principal
    Component.onCompleted: {
        showMainMenu();
    }
}
