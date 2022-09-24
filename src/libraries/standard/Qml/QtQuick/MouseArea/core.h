#ifndef MOUSE_AREA__CORE_H
#define MOUSE_AREA__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//MOUSE_AREA__CORE_H
