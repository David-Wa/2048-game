#ifndef COLORPICKER_H
#define COLORPICKER_H

#include <QObject>

class ColorPicker: public QObject

{ Q_OBJECT
public:
    ColorPicker();

    // Méthode pour obtenir la couleur du pixel à (x, y)
    Q_INVOKABLE QString getPixelColor(int x, int y);//, const QString &imagePath);
};

#endif // COLORPICKER_H


