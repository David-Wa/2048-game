import QtQuick
import QtQuick.Window
import QtQuick.Controls


Window {

    id: mainWindow
    width: 480
    height: 640
    visible: true
    title: "2048"
    color: maincolor


    // Dimensions de la grille et des tuiles
    property int cellSize: 0.7*width/taille
    property int cellSpacing: 0.12*cellSize
    property int gridMargin: 40/taille
    // Déclaration de la variable dans l'objet Window
    property string maincolor: "#FFE6A7"
    property string mainfont: "Segoe UI"
    property int taille:5
    property int difficultyLevel: gameController.getDifficultyLevel()

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
            color: "#6F1D1B"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20
        }

        Button{
            id:openMenu
            font.family:mainfont
            anchors.top: scoreBox.top
            anchors.left: gameTitle.right
            anchors.leftMargin: 28
            anchors.topMargin: 0
            width: 120
            height: 40
            onClicked:{
            menuWindow.visible=true}

            contentItem: Text {
                text: "Menu"
                font {
                        family: mainfont
                        pixelSize: 18
                        bold: true  // optionnel
                    }
                color: "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                color: "#BB9457"
                radius: 5
            }

        }





        Button{
            id:undoButton
            font.family:mainfont
            anchors.top: scoreBox.top
            anchors.left: gameTitle.right
            anchors.leftMargin: 28
            anchors.topMargin: 45
            width: 120
            height: 40
            onClicked:{
            gameController.undo();
             keyboardFocus.forceActiveFocus();}

            contentItem: Text {
                text: "<-"
                font {
                        family: mainfont
                        pixelSize: 18
                        bold: true  // optionnel
                    }
                color: "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                color: "#BB9457"
                radius: 5
            }

        }



        Button{
            id:redoButton
            font.family:mainfont
            anchors.top: scoreBox.top
            anchors.left: gameTitle.right
            anchors.leftMargin: 28
            anchors.topMargin: 90
            width: 120
            height: 40
            onClicked:{
            gameController.redo();
             keyboardFocus.forceActiveFocus();}

            contentItem: Text {
                text: "->"
                font {
                        family: mainfont
                        pixelSize: 18
                        bold: true  // optionnel
                    }
                color: "black"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                color: "#BB9457"
                radius: 5
            }

        }





        Button {
            id: newGameButton
            text: "Nouvelle partie"
            font.family:mainfont
            font.bold: true
            width: 120
            height: 40
            anchors.top: gameTitle.bottom
            anchors.topMargin: 2
            anchors.horizontalCenter: gameTitle.horizontalCenter
            z: 1

            onClicked: {
                console.log("Bouton nouvelle partie cliqué");
                gameController.newGame(taille);
                 keyboardFocus.forceActiveFocus();
            }

            contentItem: Text {
                text: newGameButton.text
                font: mainfont
                color: "#FFE6A7"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: "#6F1D1B"
                radius: 5
            }
        }

        Rectangle {
            id: scoreBox
            x: 372
            width: 80
            height: 50
            radius: 5
            color: "#995B2A"
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20

            Text {
                id: scoreLabel
                text: "SCORE"
                font.family: mainfont
                font.pixelSize: 13
                font.bold: true
                color: "#FFE6A7"
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
                color: "#FFE6A7"
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
            color: "#432818"
            anchors.right: scoreBox.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20

            Text {
                id: bestScoreLabel
                text: "MEILLEUR"
                font.family: mainfont
                font.pixelSize: 13
                font.bold: true
                color: "#FFE6A7"
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
                color: "#FFE6A7"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
            }
        }
    }

    Rectangle {
        id: gameGridBackground
        width: taille * cellSize + (taille + 1) * cellSpacing
        height: taille * cellSize + (taille + 1) * cellSpacing
        color: "#BB9457"
        radius: 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 58

        Grid {
            id: gameGrid
            anchors.fill: parent
            anchors.margins: gridMargin
            rows: taille
            columns: taille
            spacing: cellSpacing

            Repeater {
                model: taille*taille
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
                model: taille*taille

                Tile {
                    width: cellSize
                    height: cellSize
                    x: (index % taille) * (cellSize + cellSpacing)
                    y: Math.floor(index / taille) * (cellSize + cellSpacing)
                    value: {
                        var row = Math.floor(index / taille);
                        var col = index % taille;
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
            tilesRepeater.model = taille*taille;
        }

        function onDifficultyLevelChanged() {
                difficultyLevel = gameController.getDifficultyLevel();
                console.log("QML: Niveau de difficulté mis à jour:", difficultyLevel);
            }
    }

    Dialog {
                id: gameOverDialog
                title: "Game Over"
                modal: true
                anchors.centerIn: parent
                width: parent.width * 0.8
                height: parent.height * 0.4
                closePolicy: Dialog.CloseOnEscape
                visible: false

                // Style du Dialog
                background: Rectangle {
                    color: "#2c3e50"  // Bleu foncé
                    radius: 10
                    border.width: 2
                    border.color: "#34495e"
                }

                // Style du header (titre)
                header: Rectangle {
                    color: "#34495e"  // Bleu encore plus foncé
                    height: 50
                    radius: 8

                    Text {
                        text: gameOverDialog.title
                        color: "#f1c40f"  // Jaune
                        font.pixelSize: 24
                        font.bold: true
                        anchors.centerIn: parent
                    }
                }

                // Contenu du Dialog
                contentItem: Item {
                    width: parent.width
                    height: 100

                    Text {
                        text: "Partie terminée. \n Vous n'avez pas pu atteindre 2048,\n retentez votre chance !"
                        color: "#ecf0f1"  // Blanc/gris clair
                        font.pixelSize: 18
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter

                    }
                }

                // Style des boutons
                footer: Rectangle {
                    color: "transparent"
                    height: 70

                    Button {
                        text: "Nouvelle Partie"
                        anchors.centerIn: parent
                        width: 180
                        height: 45

                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 16
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            color: parent.down ? "#c0392b" : parent.hovered ? "#e74c3c" : "#d35400"  // Nuances de rouge-orange
                            radius: 6

                            // Animation sur survol
                            Behavior on color {
                                ColorAnimation { duration: 150 }
                            }
                        }

                        onClicked: {
                            gameController.newGame(taille);
                            gameOverDialog.close();
                        }
                    }
                }
            }



    Dialog {
                id: gameWonDialog
                title: "Victoire!"
                modal: true
                anchors.centerIn: parent
                width: parent.width * 0.8
                height: parent.height * 0.4
                closePolicy: Dialog.CloseOnEscape
                visible: false

                // Style du Dialog
                background: Rectangle {
                    color: "#2c3e50"  // Bleu foncé
                    radius: 10
                    border.width: 2
                    border.color: "#27ae60"  // Bordure verte
                }

                // Style du header (titre)
                header: Rectangle {
                    color: "#27ae60"  // Vert
                    height: 50
                    radius: 8

                    Text {
                        text: gameWonDialog.title
                        color: "white"
                        font.pixelSize: 24
                        font.bold: true
                        anchors.centerIn: parent
                    }
                }

                // Contenu du Dialog
                contentItem: Item {
                    width: parent.width
                    height: 100

                    Text {
                        text: "Félicitations! Vous avez atteint 2048! "
                        color: "#ecf0f1"  // Blanc/gris clair
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        anchors.centerIn: parent
                    }
                }

                // Style des boutons
                footer: Rectangle {
                    color: "transparent"
                    height: 70

                    Button {
                        text: "Continuer"
                        anchors.centerIn: parent
                        width: 180
                        height: 45

                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 16
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            color: parent.down ? "#1e8449" : parent.hovered ? "#2ecc71" : "#27ae60"  // Nuances de vert
                            radius: 6

                            // Animation sur survol
                            Behavior on color {
                                ColorAnimation { duration: 150 }
                            }
                        }

                        onClicked: {
                            gameWonDialog.close();
                        }
                    }
                }
            }


    Rectangle {
        id: controlsArea
        width: parent.width
        height: 100
        color: "#BB9457"
        anchors.top: gameGridBackground.bottom
        anchors.topMargin: 10

        Text {
            id: instructions
            text: "Utilisez les flèches pour déplacer les tuiles. Les tuiles de même valeur fusionnent lorsqu'elles se touchent. Obtenez 2048 pour gagner!"
            font.family: mainfont
            font.pixelSize: 16
            color: "#432818"
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
        spacing: 30
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter


        MenuButton { id: bouton_couleur
            anchors.horizontalCenter: parent.horizontalCenter
            buttonText: "Couleur"
            // Connexion au signal 'openMenu' pour ouvrir une nouvelle fenêtre
            Connections {
                target: vueObjetBtn
                function onOpenMenu()  {if (vueObjetBtn.buttonName==="Couleur"){
                    colorWindow.visible = true;  // Ouvre la fenêtre du menu en la rendant visible
                        menuWindow.visible=false;
              }
            }}

}


        MenuButton { id: bouton_taille
                anchors.horizontalCenter: parent.horizontalCenter
                buttonText: "Taille"
                // Connexion au signal 'openMenu' pour ouvrir une nouvelle fenêtre
                Connections {
                    target: vueObjetBtn
                    function onOpenMenu() {
                        if (vueObjetBtn.buttonName === "Taille") {
                            heightWindow.visible = true;
                            menuWindow.visible = false; // Ouvre la fenêtre du menu en la rendant visible
                        }
                    }
                }
        }



                MenuButton { id: bouton_police
                    y: 198
                    anchors.horizontalCenter: parent.horizontalCenter
                    buttonText: "Police"
                    // Connexion au signal 'openMenu' pour ouvrir une nouvelle fenêtre
                    Connections {
                        target: vueObjetBtn
                        function onOpenMenu(){
                            if (vueObjetBtn.buttonName==="Police"){
                                policeWindow.visible = true;
                                menuWindow.visible=false;// Ouvre la fenêtre du menu en la rendant visible
                            }
                        }
                    }
                }

                MenuButton {
                    id: bouton_difficulte
                    anchors.horizontalCenter: parent.horizontalCenter
                    buttonText: "Difficulté"
                    // Connexion au signal 'openMenu'
                    Connections {
                        target: vueObjetBtn
                        function onOpenMenu() {
                            if (vueObjetBtn.buttonName === "Difficulté") {
                                difficultyWindow.visible = true;
                                menuWindow.visible = false;
                            }
                        }
                    }
                }





    }






}






 // La fenêtre qui sera ouverte lorsque le bouton Couleurs est cliqué


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







// La fenêtre qui sera ouverte lorsque le bouton Taille est cliqué
Rectangle {
    id: heightWindow
    anchors.fill: parent
    visible: false  // Initialement, la fenêtre est invisible
    color: maincolor  // Couleur de fond de la fenêtre


    Rectangle {
        width: 300
        height: 50
        color: "white"
        radius: 10
        border.color: "#cccccc"
        border.width: 2
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            text: "Choisissez la taille\n de la grille de jeu"
            font.family:mainfont
            font.pixelSize: 20
            font.bold: true
            color: "#333"
            anchors.centerIn: parent
        }
    }

    Column {
        width: parent.width * 0.8
        height: 400
        spacing: 20  // Espacement entre les boutons
        anchors.centerIn: parent

        // Style des boutons
        Button {
            text: "Grille 4X4"
            font.family: mainfont
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: "#4CAF50"  // Couleur de fond verte
                radius: 10  // Coins arrondis
                border.color: "#388E3C"  // Couleur de bordure
                border.width: 2
            }


            contentItem: Text {
                text: "Grille 4X4"
                font.pixelSize: 18
                color: "white"
                font.bold: true
            }
            onClicked: {
                if (taille != 4) {
                    taille = 4;
                    gameController.newGame(taille);
                }
            }
        }

        Button {
            text: "Grille 5X5"
            font.family: mainfont
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: "#2196F3"  // Couleur de fond bleue
                radius: 10
                border.color: "#1976D2"
                border.width: 2
            }
            contentItem: Text {
                text: "Grille 5X5"
                font.pixelSize: 18
                color: "white"
                font.bold: true
            }
            onClicked: {
                if (taille != 5) {
                    taille = 5;
                    gameController.newGame(taille);
                }
            }
        }

        Button {
            text: "Grille 6X6"
            font.family: mainfont
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: "#FF9800"  // Couleur de fond orange
                radius: 10
                border.color: "#F57C00"
                border.width: 2
            }
            contentItem: Text {
                text: "Grille 6X6"
                font.pixelSize: 18
                color: "white"
                font.bold: true
            }
            onClicked: {
                if (taille != 6) {
                    taille = 6;
                    gameController.newGame(taille);
                }
            }
        }

        Button {
            text: "Grille 7X7"
            font.family: mainfont
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: "#FF5722"  // Couleur de fond rouge-orange
                radius: 10
                border.color: "#D32F2F"
                border.width: 2
            }
            contentItem: Text {
                text: "Grille 7X7"
                font.pixelSize: 18
                color: "white"
                font.bold: true
            }
            onClicked: {
                if (taille != 7) {
                    taille = 7;
                    gameController.newGame(taille);
                }
            }
        }

        Button {
            text: "Grille 8X8"
            font.family: mainfont
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: "#9C27B0"  // Couleur de fond violet
                radius: 10
                border.color: "#7B1FA2"
                border.width: 2
            }
            contentItem: Text {
                text: "Grille 8X8"
                font.pixelSize: 18
                color: "white"
                font.bold: true
            }
            onClicked: {
                if (taille != 8) {
                    taille = 8;
                    gameController.newGame(taille);
                }
            }
        }
    }

    // Bouton de fermeture
    Button {
        text: "X"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        background: Rectangle {
            color: "#ff6666"  // Couleur rouge pour le bouton de fermeture
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

        // Effet visuel de survol (change de couleur lorsqu'on survole)
        MouseArea {
            anchors.fill: parent
            onClicked: parent.clicked()
            onHoveredChanged: {
                if (parent.containsMouse) {
                    parent.background.color = "#FF4D4D";  // Couleur plus foncée au survol
                } else {
                    parent.background.color = "#FF6666";  // Couleur d'origine
                }
            }
        }
    }
}



// La fenêtre qui sera ouverte lorsque le bouton Police est cliqué



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




// La fenêtre qui sera ouverte pour la difficulté
Rectangle {
    id: difficultyWindow
    anchors.fill: parent
    visible: false
    color: maincolor

    Rectangle {
        width: 300
        height: 50
        color: "white"
        radius: 10
        border.color: "#cccccc"
        border.width: 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50

        Text {
            text: "Niveau de difficulté"
            font.family: mainfont
            font.pixelSize: 20
            font.bold: true
            color: "#333"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        width: 300
        height: 50
        color: "white"
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 120

        Text {
            text: "Plus le niveau est élevé, plus vous obtiendrez de tuiles 4"
            font.family: mainfont
            font.pixelSize: 16
            color: "#666"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Column {
        width: parent.width * 0.8
        height: 300
        spacing: 20
        anchors.centerIn: parent

        Button {
            text: "Facile"
            font.family: mainfont
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200
            height: 50

            background: Rectangle {
                color: "#4CAF50"
                radius: 10
                border.color: "#388E3C"
                border.width: 2
            }

            contentItem: Text {
                text: "Facile (10% de 4)"
                font.family: mainfont
                font.pixelSize: 16
                color: "white"
                font.bold: true
            }

            onClicked: {
                gameController.setDifficultyLevel(1);
                console.log("Difficulté réglée sur: Facile");
            }
        }

        Button {
            text: "Moyen"
            font.family: mainfont
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200
            height: 50

            background: Rectangle {
                color: "#FF9800"
                radius: 10
                border.color: "#F57C00"
                border.width: 2
            }

            contentItem: Text {
                text: "Moyen (25% de 4)"
                font.family: mainfont
                font.pixelSize: 16
                color: "white"
                font.bold: true
            }

            onClicked: {
                gameController.setDifficultyLevel(2);
                console.log("Difficulté réglée sur: Moyen");
            }
        }

        Button {
            text: "Difficile"
            font.family: mainfont
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200
            height: 50

            background: Rectangle {
                color: "#F44336"
                radius: 10
                border.color: "#D32F2F"
                border.width: 2
            }

            contentItem: Text {
                text: "Difficile (40% de 4)"
                font.family: mainfont
                font.pixelSize: 16
                color: "white"
                font.bold: true
            }

            onClicked: {
                gameController.setDifficultyLevel(3);
                console.log("Difficulté réglée sur: Difficile");
            }
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
            difficultyWindow.visible = false;
            menuWindow.visible = true;
        }
    }
}
}
