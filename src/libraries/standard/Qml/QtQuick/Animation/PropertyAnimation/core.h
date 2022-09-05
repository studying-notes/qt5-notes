#ifndef PROPERTY_ANIMATION__CORE_H
#define PROPERTY_ANIMATION__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//PROPERTY_ANIMATION__CORE_H
