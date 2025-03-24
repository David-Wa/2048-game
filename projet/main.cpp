#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "menubutton.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    Bouton aButton ;
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("vueObjetBtn", &aButton);
    engine.loadFromModule("Projet", "InterfaceMenu");

    return app.exec();
}
