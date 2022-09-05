#ifndef RANGE_SLIDER_FLAT__CORE_H
#define RANGE_SLIDER_FLAT__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//RANGE_SLIDER_FLAT__CORE_H
