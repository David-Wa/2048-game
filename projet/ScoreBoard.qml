import QtQuick
import QtQuick.Layouts

Row {
    id: scoreBoard
    spacing: 10

    // Propriétés pour suivre les scores
    property int currentScore: 0
    property int bestScore: 0

    // Composant pour un affichage de score
    Component {
        id: scoreDisplay

        Rectangle {
            width: 100
            height: 60
            radius: 3
            color: "#BBADA0"

            property string label: "SCORE"
            property int score: 0

            Column {
                anchors.centerIn: parent
                spacing: 2

                // Label du score
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: parent.parent.label
                    font.family: "Helvetica"
                    font.pixelSize: 13
                    color: "#EEE4DA"
                }

                // Valeur du score
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: parent.parent.score
                    font.family: "Helvetica"
                    font.pixelSize: 25
                    font.bold: true
                    color: "white"
                }
            }
        }
    }

    // Score actuel
    Loader {
        id: currentScoreLoader
        sourceComponent: scoreDisplay
        onLoaded: {
            item.label = "SCORE";
            item.score = Qt.binding(function() { return scoreBoard.currentScore; });
        }
    }

    // Meilleur score
    Loader {
        id: bestScoreLoader
        sourceComponent: scoreDisplay
        onLoaded: {
            item.label = "MEILLEUR";
            item.score = Qt.binding(function() { return scoreBoard.bestScore; });
        }
    }

    // Mettre à jour le score actuel
    function updateScore(points) {
        currentScore += points;

        // Mettre à jour le meilleur score si nécessaire
        if (currentScore > bestScore) {
            bestScore = currentScore;
            // Idéalement, sauvegarder le meilleur score ici
        }
    }

    // Réinitialiser le score actuel
    function resetScore() {
        currentScore = 0;
    }
}
