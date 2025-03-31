import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: mainWindow
    width: 480
    height: 640
    visible: true
    title: "2048"
    color: "#FAF8EF"

    // Dimensions de la grille et des tuiles
    property int cellSize: 80
    property int cellSpacing: 10
    property int gridMargin: 10

    Item {
        id: keyboardFocus
        focus: true
        anchors.fill: parent

        // Gestion des touches clavier
        Keys.onPressed: function(event) {
            console.log("Touche pressée:", event.key);
            if (event.key === Qt.Key_Up) {
                console.log("Déplacement vers le haut");
                gameController.move(0); // UP
                event.accepted = true;
            } else if (event.key === Qt.Key_Right) {
                console.log("Déplacement vers la droite");
                gameController.move(1); // RIGHT
                event.accepted = true;
            } else if (event.key === Qt.Key_Down) {
                console.log("Déplacement vers le bas");
                gameController.move(2); // DOWN
                event.accepted = true;
            } else if (event.key === Qt.Key_Left) {
                console.log("Déplacement vers la gauche");
                gameController.move(3); // LEFT
                event.accepted = true;
            }
        }

        // Pour tester si les événements clavier sont capturés
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Clic détecté - Focus sur l'élément des touches");
                keyboardFocus.forceActiveFocus();
            }
        }
    }

    Rectangle {
        id: header
        x: 0
        width: parent.width
        height: 100
        color: "#FAF8EF"
        anchors.top: parent.top
        anchors.topMargin: 9

        Text {
            id: gameTitle
            text: "2048"
            font.pixelSize: 40
            font.bold: true
            color: "#776e65"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 40
            anchors.verticalCenter: parent.verticalCenter
        }

        Button{
            id:openMenu
            text: "="
            width: 40
            height: 40
            anchors.top: header.top
            anchors.horizontalCenter: header.horizontalCenter
            onClicked:{
            menuWindow.visible=true}
        }

        Button {
            id: newGameButton
            text: "Nouvelle partie"
            width: 120
            height: 40
            anchors.top: gameTitle.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: gameTitle.horizontalCenter
            z: 1

            onClicked: {
                console.log("Bouton nouvelle partie cliqué");
                gameController.newGame();
            }

            contentItem: Text {
                text: newGameButton.text
                font: newGameButton.font
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: "#8f7a66"
                radius: 5
            }
        }

        Rectangle {
            id: scoreBox
            x: 372
            width: 80
            height: 50
            radius: 5
            color: "#7B1113"
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: scoreLabel
                text: "SCORE"
                font.family: "Arial"
                font.pixelSize: 13
                font.bold: true
                color: "#eee4da"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 5
            }

            Text {
                id: scoreValue
                text: gameController.getScore()
                font.family: "Arial"
                font.pixelSize: 25
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
            }
        }

        Rectangle {
            id: bestScoreBox
            width: 80
            height: 50
            radius: 5
            color: "#00008B"
            anchors.right: scoreBox.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: bestScoreLabel
                text: "MEILLEUR"
                font.family: "Arial"
                font.pixelSize: 13
                font.bold: true
                color: "#eee4da"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 5
            }

            Text {
                id: bestScoreValue
                text: gameController.getBestScore()
                font.family: "Arial"
                font.pixelSize: 25
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
            }
        }
    }

    Rectangle {
        id: gameGridBackground
        width: 4 * cellSize + 5 * cellSpacing
        height: 4 * cellSize + 5 * cellSpacing
        color: "#bbada0"
        radius: 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 20

        Grid {
            id: gameGrid
            anchors.fill: parent
            anchors.margins: gridMargin
            rows: 4
            columns: 4
            spacing: cellSpacing

            Repeater {
                model: 16
                Cell {
                    width: cellSize
                    height: cellSize
                }
            }
        }

        Item {
            id: tilesContainer
            anchors.fill: gameGrid
            anchors.margins: 0

            Repeater {
                id: tilesRepeater
                model: 16

                Tile {
                    width: cellSize
                    height: cellSize
                    x: (index % 4) * (cellSize + cellSpacing)
                    y: Math.floor(index / 4) * (cellSize + cellSpacing)
                    value: {
                        var row = Math.floor(index / 4);
                        var col = index % 4;
                        var tileValue = gameController.boardModel.getTileValue(row, col);
                        return tileValue;
                    }
                    opacity: value === 0 ? 0 : 1
                }
            }
        }
    }

    Connections {
        target: gameController

        function onScoreChanged() {
            console.log("Score changé:", gameController.getScore());
            scoreValue.text = gameController.getScore();
        }

        function onBestScoreChanged() {
            console.log("Meilleur score changé:", gameController.getBestScore());
            bestScoreValue.text = gameController.getBestScore();
        }

        function onGameOverChanged() {
            console.log("État du jeu changé - Game Over:", gameController.isGameOver());
            if (gameController.isGameOver()) {
                gameOverDialog.visible = true;
            }
        }

        function onGameWonChanged() {
            console.log("État du jeu changé - Victoire:", gameController.isGameWon());
            if (gameController.isGameWon()) {
                gameWonDialog.visible = true;
            }
        }

        function onBoardModelChanged() {
            console.log("Modèle du plateau changé");
            tilesRepeater.model = 0;
            tilesRepeater.model = 16;
        }
    }

    Dialog {
        id: gameOverDialog
        title: "Game Over"
        standardButtons: Dialog.Ok
        anchors.centerIn: parent
        visible: false
        modal: true

        onAccepted: {
            gameController.newGame();
            close();
        }

        Text {
            text: "Partie terminée! Votre score: " + gameController.getScore()
        }
    }

    Dialog {
        id: gameWonDialog
        title: "Victoire!"
        standardButtons: Dialog.Ok
        anchors.centerIn: parent
        visible: false
        modal: true

        onAccepted: {
            close();
        }

        Text {
            text: "Félicitations! Vous avez atteint 2048!"
        }
    }

    Rectangle {
        id: controlsArea
        width: parent.width
        height: 100
        color: "#8f7a66"
        anchors.top: gameGridBackground.bottom
        anchors.topMargin: 20

        Text {
            id: instructions
            text: "Utilisez les flèches pour déplacer les tuiles. Les tuiles de même valeur fusionnent lorsqu'elles se touchent. Obtenez 2048 pour gagner!"
            font.family: "Arial"
            font.pixelSize: 16
            color: "white"
            wrapMode: Text.WordWrap
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
        }
    }

    // Forcer le focus sur l'élément qui gère les touches au démarrage
    Component.onCompleted: {
        keyboardFocus.forceActiveFocus();
        console.log("Fenêtre initialisée, focus défini sur l'élément de clavier");
    }






//____________________Menu____________________________________________


Rectangle {
    id: menuWindow
    width: 480
    height: 640
    visible: false
    color: "#FAF8EF"

    Rectangle {
        id: menuheader
        x: 0
        width: parent.width
        height: 100
        color: "#FAF8EF"
        anchors.top: parent.top
        anchors.topMargin: 9

        Text {
            id: menuTitle
            text: "2048-Paramètres"
            font.pixelSize: 40
            font.bold: true
            color: "#776e65"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 40
            anchors.verticalCenter: parent.verticalCenter
        }
    }


    Button{
        text:"X"
        anchors.top:parent.top;
        anchors.right:parent.right;
    onClicked: {
        menuWindow.visible = false;
        keyboardFocus.forceActiveFocus();  // Réactive le focus sur le jeu
    }
    }

    Column {
        id: column
        width: 200
        height: 400
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter






        MenuButton { id: bouton_couleur
            anchors.top: parent.top
        anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            buttonText: "Couleur"
            // Connexion au signal 'openMenu' pour ouvrir une nouvelle fenêtre
            Connections {
                target: vueObjetBtn
                onOpenMenu: {if (vueObjetBtn.buttonName==="Couleur"){
                    colorWindow.visible = true;  // Ouvre la fenêtre du menu en la rendant visible
              }
            }}

}


        MenuButton { id: bouton_taille
            anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                buttonText: "Taille"
                // Connexion au signal 'openMenu' pour ouvrir une nouvelle fenêtre
                Connections {
                    target: vueObjetBtn
                    onOpenMenu: {if (vueObjetBtn.buttonName==="Taille"){
                        heightWindow.visible = true;  // Ouvre la fenêtre du menu en la rendant visible
                                    }}
                }}



                MenuButton { id: bouton_police
                    y: 198
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    buttonText: "Police"
                    // Connexion au signal 'openMenu' pour ouvrir une nouvelle fenêtre
                    Connections {
                        target: vueObjetBtn
                        onOpenMenu: {if (vueObjetBtn.buttonName==="Police"){
                            policeWindow.visible = true;  // Ouvre la fenêtre du menu en la rendant visible
                                        }}
                    }}

        }















    // La fenêtre qui sera ouverte lorsque le bouton est cliqué
    // La fenêtre qui sera ouverte lorsque le bouton est cliqué

    // La fenêtre qui sera ouverte lorsque le bouton est cliqué

        Rectangle {
            id: colorWindow
            width: parent.width
            height: parent.height
            color: "#f0f0f0"
            visible: false  // Initialement, la fenêtre est invisible

            Text {
                text: "Voici votre menu"
                font.pixelSize: 20
                font.family: "Tahoma"
            }

            Button{
                text:"X"
                anchors.top:parent.top;
                anchors.right:parent.right;
            onClicked: colorWindow.visible = false;
            }
            Image {
                    id: myImage
                    x: 0
                    y: 0
                    source: "couleurs.jpg"  // Remplace par ton image
                    width: 300
                    height: 160
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var xCoord = mouseX
                            var yCoord = mouseY
                            colorCanvas.getPixelColor(xCoord, yCoord)
                        }
                    }
                }

                // Canvas pour récupérer la couleur du pixel
                Canvas {
                    id: colorCanvas
                    width: myImage.width
                    height: myImage.height
                    anchors.centerIn: parent

                    onPaint: {
                        var context = getContext("2d")
                        context.drawImage(myImage, 0, 0)
                    }

                    // Fonction pour obtenir la couleur du pixel
                    function getPixelColor(x, y) {
                        var context = getContext("2d")
                        var pixelData = context.getImageData(x, y, 1, 1).data
                        var color = "rgba(" + pixelData[0] + ", " + pixelData[1] + ", " + pixelData[2] + ", " + (pixelData[3] / 255) + ")"
                        console.log("Couleur du pixel (" + x + ", " + y + "): " + color)
                    }
                }
}





// La fenêtre qui sera ouverte lorsque le bouton est cliqué

        Rectangle {
            id: heightWindow
            width: parent.width * 0.8
                   height: parent.height * 0.5
                   color: "#E0E0E0"
                   border.color: "black"
                   border.width: 2
                   radius: 10
            visible: false  // Initialement, la fenêtre est invisible

            Text {
                text: "Voici votre menu"
                font.pixelSize: 20
                font.family: "Tahoma"
            }


        Button{
            text:"X"
            anchors.top:parent.top;
            anchors.right:parent.right;
        onClicked: heightWindow.visible = false;
        }
}



// La fenêtre qui sera ouverte lorsque le bouton est cliqué


        Rectangle {
               visible: false  // Initialement, la fenêtre est invisible
             id: policeWindow
            width: parent.width
            height: parent.height
            color: "#f0f0f0"

            Text {
                text: "Choisissez la police du jeu"
                font.pixelSize: 20
                font.family: "Tahoma"
            }



        ComboBox {
              id: comboBox
              width: 150
              model: ["Segoe UI", "Arial", "Courier","Tahoma","Times New Roman","Verdana"]
            currentIndex: 0  // La valeur initiale est "Segoe UI" (index 0)
             // Définition du delegate pour personnaliser chaque élément
                    delegate: Item {
                        width: 200
                        height: 40

                        // Le texte de chaque option
                        Text {
                            text: modelData
                            font.pixelSize: 20
                            font.family: modelData
                            anchors.centerIn: parent
                        }
                    }

              onActivated: console.log("Sélectionné:",comboBox.currentText)
          }
        Button{
            text:"X"
            anchors.top:parent.top;
            anchors.right:parent.right;
        onClicked: policeWindow.visible = false;
        }
}


}


}
