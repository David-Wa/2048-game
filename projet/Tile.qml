import QtQuick 2.15

Rectangle {
    id: root
    // Les dimensions seront définies par le parent (main.qml)
    width: 80
    height: 80
    radius: 5

    property int value: 0

    // Couleurs pour différentes valeurs
    function getTileColor(value) {
        switch(value) {
        case 2: return "#F5EED6";       // Beige très clair
        case 4: return "#F0E0C0";       // Beige clair
        case 8: return "#E6BC80";       // Doré clair
        case 16: return "#D9A76C";      // Doré moyen
        case 32: return "#C58C58";      // Doré-brun
        case 64: return "#B17645";      // Marron-orange
        case 128: return "#9F654A";     // Brun-rouge
        case 256: return "#8C543F";     // Brun foncé
        case 512: return "#774936";     // Brun-chocolat
        case 1024: return "#613E2F";    // Marron foncé
        case 2048: return "#4A3228";    // Marron très foncé
        default: return "#D3C2A9";
        }
    }

    // Couleur du texte selon la valeur
    function getTextColor(value) {
        return (value <= 36) ?"#5A3D30" : "#F5EED6";
    }

    // Taille du texte selon la longueur du nombre
    function getFontSize(value) {
        // Récupérer la taille de la grille depuis la propriété globale
                let gridSize = taille;

                // Coefficient de base basé sur la taille de la tuile
                let baseSize = root.width / 2;

                // Facteur de réduction basé sur la longueur du nombre
                let valueStr = value.toString();
                let lengthFactor = 1;

                if (valueStr.length > 3) {
                    lengthFactor = 0.6; // 4 chiffres (1024, 2048)
                } else if (valueStr.length > 2) {
                    lengthFactor = 0.7; // 3 chiffres (128, 256, 512)
                } else if (valueStr.length > 1) {
                    lengthFactor = 0.85; // 2 chiffres (16, 32, 64)
                }

                // Calcul final de la taille de police
                return baseSize * lengthFactor;
    }

    color: getTileColor(value)

    Text {
        anchors.centerIn: parent
        text: value !== 0 ? value : ""
        font.family: mainfont
        font.bold: true
        font.pixelSize: getFontSize(value)
        color: getTextColor(value)
    }

    // Animation lors de l'apparition
    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    // Animation lors du changement de valeur
    Behavior on color {
        ColorAnimation { duration: 100 }
    }

    // Effet visuel lors de la création d'une nouvelle tuile
    ParallelAnimation {
        id: newTileAnimation
        running: value > 0
        NumberAnimation {
            target: root
            property: "scale"
            from: 0.1
            to: 1
            duration: 200
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: root
            property: "rotation"
            from: -10
            to: 0
            duration: 200
            easing.type: Easing.OutCubic
        }
    }
}
