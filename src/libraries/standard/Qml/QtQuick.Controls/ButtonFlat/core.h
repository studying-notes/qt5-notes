#ifndef BUTTON_FLAT__CORE_H
#define BUTTON_FLAT__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//BUTTON_FLAT__CORE_H
