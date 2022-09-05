#ifndef DELAY_BUTTON__CORE_H
#define DELAY_BUTTON__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//DELAY_BUTTON__CORE_H
