#ifndef ROTATION_ANIMATION__CORE_H
#define ROTATION_ANIMATION__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//ROTATION_ANIMATION__CORE_H
