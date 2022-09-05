#ifndef CAMERA__CORE_H
#define CAMERA__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//CAMERA__CORE_H
