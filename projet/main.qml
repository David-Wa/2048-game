import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15


Window {

    id: mainWindow
    width: 480
    height: 640
    visible: true
    title: "2048"
    color: maincolor


    // Dimensions de la grille et des tuiles
    property int cellSize: 80
    property int cellSpacing: 10
    property int gridMargin: 10
    // Déclaration de la variable dans l'objet Window
    property string maincolor: "#FAF8EF"
    property string mainfont: "Sergoe UI"

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
        color: maincolor
        anchors.top: parent.top
        anchors.topMargin: 9

        Text {
            id: gameTitle
            text: "2048"
            font.family:mainfont
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
            font.family:mainfont
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
            font.family:mainfont
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
                font: mainfont
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
                font.family: mainfont
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
                font.family: mainfont
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
                font.family: mainfont
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
                font.family: mainfont
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
            font.family:mainfont
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
            font.family:mainfont
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
            font.family: mainfont
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
    color: maincolor

    Rectangle {
        id: menuheader
        x: 0
        width: parent.width
        height: 100
        color: maincolor
        anchors.top: parent.top
        anchors.topMargin: 9

        Text {
            id: menuTitle
            text: "2048-Paramètres"
            font.family:mainfont
            font.pixelSize: 40
            font.bold: true
            color: "#776e65"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 40
            anchors.verticalCenter: parent.verticalCenter
        }
    }


    // Bouton de fermeture
    Button {
        text: "X"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        background: Rectangle {
            color: "#ff6666"
            radius: 10
        }
        contentItem: Text {
            text: "X"
            font.pixelSize: 18
            color: "white"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
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
                        menuWindow.visible=false;
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
                        heightWindow.visible = true;
                            menuWindow.visible=false;// Ouvre la fenêtre du menu en la rendant visible
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
                            policeWindow.visible = true;
                                menuWindow.visible=false;// Ouvre la fenêtre du menu en la rendant visible
                                        }}
                    }}

        }





}









    // La fenêtre qui sera ouverte lorsque le bouton est cliqué
    // La fenêtre qui sera ouverte lorsque le bouton est cliqué

    // La fenêtre qui sera ouverte lorsque le bouton est cliqué


Rectangle {
    id: colorWindow
    width: parent.width
    height: parent.height
    color: maincolor
    visible: false  // La fenêtre est affichée au démarrage

    Column {
        anchors.centerIn: parent
        spacing: 20

        // Titre du menu
        // Titre du menu avec un cadre blanc
             Rectangle {
                 width: 300
                 height: 50
                 color: "white"
                 radius: 10
                 border.color: "#cccccc"
                 border.width: 2
                 anchors.horizontalCenter: parent.horizontalCenter

                 Text {
                     text: "Personnalisation du Jeu"
                     font.family:mainfont
                     font.pixelSize: 20
                     font.bold: true
                     color: "#333"
                     anchors.centerIn: parent
                 }
             }
        // Indication pour le joueur

             Rectangle {
                 width: 300
                 height: 50
                 color: "white"
                 radius: 10
                 anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text: "Cliquez sur l'image pour choisir la couleur du jeu!"
            font.family:mainfont
            font.pixelSize: 16
            color: "#666"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
        }}

        // Image cliquable
        Image {
            id: myImage
            width: 300
            height: 160
            source: "couleurs.jpg"  // Image des couleurs
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent
                onClicked: (mouse) => {
                    var x = Math.floor(mouse.x * myImage.sourceSize.width / myImage.width);
                    var y = Math.floor(mouse.y * myImage.sourceSize.height / myImage.height);


                    // Récupération de la couleur via C++
                    var color = colorPicker.getPixelColor(x, y);
                    console.log("Couleur du pixel sélectionnée : " + color);
                    console.log(x+' et '+y);
                    maincolor = color;
                }
            }
        }
    }
    // Footnote - Source de l'image
               Text {
                   text: "Source de l'image : Unsplash / Pexels"
                   font.pixelSize: 12
                   color: "#999"
                   horizontalAlignment: Text.AlignHCenter
                   anchors.horizontalCenter: parent.horizontalCenter
               }


    // Bouton de fermeture
    Button {
        text: "X"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        background: Rectangle {
            color: "#ff6666"
            radius: 10
        }
        contentItem: Text {
            text: "X"
            font.pixelSize: 18
            color: "white"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        onClicked: {
            colorWindow.visible = false;
            menuWindow.visible = true;
        }
    }
}







// La fenêtre qui sera ouverte lorsque le bouton est cliqué

        Rectangle {
            id: heightWindow
            anchors.fill: parent
            visible: false  // Initialement, la fenêtre est invisible

            Column {
                width: 200
                height: 400
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter


                Button {
                    text:"4"
                    font.family:mainfont
                    anchors.top: parent.top
                 anchors.horizontalCenter: parent.horizontalCenter

                }

                Button {
                    text:"5"
                    font.family:mainfont
                    anchors.verticalCenter: parent.verticalCenter
                 anchors.horizontalCenter: parent.horizontalCenter

                }

            Button {
                text:"6"
                font.family:mainfont
                anchors.bottom: parent.bottom
             anchors.horizontalCenter: parent.horizontalCenter

            }

}

            // Bouton de fermeture
            Button {
                text: "X"
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 10
                background: Rectangle {
                    color: "#ff6666"
                    radius: 10
                }
                contentItem: Text {
                    text: "X"
                    font.pixelSize: 18
                    color: "white"
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                   heightWindow.visible = false;
                    menuWindow.visible = true;
                }
            }

}



// La fenêtre qui sera ouverte lorsque le bouton est cliqué



        Rectangle {
            id: policeWindow
            width: parent.width
            height: parent.height
            color: maincolor
            border.color: "#cccccc"
            border.width: 1
            visible: false  // Initialement, la fenêtre est invisible

            // Titre
            Text {
                text: "Choisissez la police du jeu"
                font.pixelSize: 24
                font.family: mainfont
                color: "#333333"
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 30
            }

            // ComboBox pour choisir la police
            ComboBox {
                id: fontComboBox
                width: parent.width * 0.6
                anchors.top: parent.top
                anchors.topMargin: 100
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 18

                // Liste de polices disponibles
                model: [
                    "Arial", "Courier", "Times New Roman", "Verdana", "Comic Sans MS"
                ]

                // Fonction pour appliquer la police choisie
                onActivated: {
                    mainfont = fontComboBox.currentText
                }
            }

            // Bouton de fermeture
            Button {
                text: "X"
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 10
                background: Rectangle {
                    color: "#ff6666"
                    radius: 10
                }
                contentItem: Text {
                    text: "X"
                    font.pixelSize: 18
                    color: "white"
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    policeWindow.visible = false;
                    menuWindow.visible = true;
                }
            }
        }

}
