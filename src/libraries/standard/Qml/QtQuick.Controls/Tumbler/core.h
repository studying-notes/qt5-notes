#ifndef TUMBLER__CORE_H
#define TUMBLER__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//TUMBLER__CORE_H
