#include "colorpicker.h"
#include <QObject>
#include <QImage>
#include <QColor>
#include <QDebug>

ColorPicker::ColorPicker() {}


QString ColorPicker::getPixelColor(int x, int y)//, const QString &imagePath)
{//QImage image(imagePath);
    QImage image("/Users/anas/Documents/GitHub/2048-c/projet");


    if (image.isNull()) {
        qDebug() << "L'image n'a pas pu être chargée.";
    }


    if (x < 0 || x >= image.width() || y < 0 || y >= image.height()) {
        qDebug() << "Coordonnées hors de l'image.";}

    QColor pixelcolor = image.pixelColor(x, y);
    return pixelcolor.name();

};


