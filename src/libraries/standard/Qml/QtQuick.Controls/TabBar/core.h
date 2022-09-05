#ifndef TAB_BAR__CORE_H
#define TAB_BAR__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//TAB_BAR__CORE_H
