#ifndef SWITCH_FLAT__CORE_H
#define SWITCH_FLAT__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//SWITCH_FLAT__CORE_H
