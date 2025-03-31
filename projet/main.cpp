#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QDebug>
#include <QFile>
#include "gamecontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qDebug() << "Application 2048 démarrée";
    qDebug() << "Répertoire courant:" << QDir::currentPath();

    QQmlApplicationEngine engine;

    qDebug() << "Moteur QML créé";

    GameController* controller = new GameController();
    qDebug() << "GameController créé";

    engine.rootContext()->setContextProperty("gameController", controller);
    qDebug() << "GameController exposé au contexte QML";

    // Chemin absolu vers le dossier du projet source (pas le build)
    QString projectDir = "/Users/anas/Documents/GitHub/2048-c/projet";
    QString qmlPath = projectDir + "/main.qml";

    qDebug() << "Tentative de charger:" << qmlPath;
    qDebug() << "Le fichier existe:" << QFile::exists(qmlPath);

    // Vérifier si les fichiers auxiliaires existent également
    qDebug() << "Cell.qml existe:" << QFile::exists(projectDir + "/Cell.qml");
    qDebug() << "Tile.qml existe:" << QFile::exists(projectDir + "/Tile.qml");

    engine.load(QUrl::fromLocalFile(qmlPath));

    if (engine.rootObjects().isEmpty()) {
        qDebug() << "ERREUR: Impossible de charger main.qml";
        return -1;
    }

    qDebug() << "Interface QML chargée avec succès";

    int result = app.exec();
    qDebug() << "Application terminée avec code:" << result;
    return result;
}
