#ifndef QQUICK_STYLE__CORE_H
#define QQUICK_STYLE__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//QQUICK_STYLE__CORE_H
