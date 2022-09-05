#ifndef RANGE_SLIDER__CORE_H
#define RANGE_SLIDER__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//RANGE_SLIDER__CORE_H
