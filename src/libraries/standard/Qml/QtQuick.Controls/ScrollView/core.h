#ifndef SCROLL_VIEW__CORE_H
#define SCROLL_VIEW__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//SCROLL_VIEW__CORE_H
