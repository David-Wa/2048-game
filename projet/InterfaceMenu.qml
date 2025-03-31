import QtQuick
import QtQuick.Controls
import QtQuick.Window


Window {
    id: mainWindow
    width: 480
    height: 640
    visible: true
    title: "Settings"
    color: "#FAF8EF"

    Rectangle {
        id: header
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


