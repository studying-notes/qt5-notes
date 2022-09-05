#ifndef MENU_SEPARATOR__CORE_H
#define MENU_SEPARATOR__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//MENU_SEPARATOR__CORE_H
