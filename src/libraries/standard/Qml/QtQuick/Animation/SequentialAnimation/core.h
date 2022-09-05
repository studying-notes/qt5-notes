#ifndef SEQUENTIAL_ANIMATION__CORE_H
#define SEQUENTIAL_ANIMATION__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//SEQUENTIAL_ANIMATION__CORE_H
