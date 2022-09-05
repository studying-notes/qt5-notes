#ifndef TUMBLER_FLAT__CORE_H
#define TUMBLER_FLAT__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//TUMBLER_FLAT__CORE_H
