#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>    //ici
#include "menubutton.h"   //ici

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
     MenuButton aMenuButton;   //ici

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
      engine.rootContext()->setContextProperty("vueObjetBouton", &aMenuButton); // <-- AJOUT ICI
    engine.loadFromModule("Projet", "InterfaceMenu");

    return app.exec();
}
