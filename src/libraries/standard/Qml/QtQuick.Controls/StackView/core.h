#ifndef STACK_VIEW__CORE_H
#define STACK_VIEW__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//STACK_VIEW__CORE_H
