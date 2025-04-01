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
            case 2: return "#eee4da";
            case 4: return "#ede0c8";
            case 8: return "#f2b179";
            case 16: return "#f59563";
            case 32: return "#f67c5f";
            case 64: return "#f65e3b";
            case 128: return "#edcf72";
            case 256: return "#edcc61";
            case 512: return "#edc850";
            case 1024: return "#edc53f";
            case 2048: return "#edc22e";
            default: return "#cdc1b4";
        }
    }

    // Couleur du texte selon la valeur
    function getTextColor(value) {
        return (value <= 4) ? "#776e65" : "white";
    }

    // Taille du texte selon la longueur du nombre
    function getFontSize(value) {
        let valueStr = value.toString();
        if (valueStr.length > 3) return 22;
        else if (valueStr.length > 2) return 28;
        else return 35;
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
