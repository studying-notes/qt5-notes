#ifndef BUSY_INDICATOR__CORE_H
#define BUSY_INDICATOR__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//BUSY_INDICATOR__CORE_H
