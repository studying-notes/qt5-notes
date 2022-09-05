#ifndef SCROLL_BAR__CORE_H
#define SCROLL_BAR__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//SCROLL_BAR__CORE_H
