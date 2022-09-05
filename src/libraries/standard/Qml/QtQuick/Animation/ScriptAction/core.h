#ifndef SCRIPT_ACTION__CORE_H
#define SCRIPT_ACTION__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//SCRIPT_ACTION__CORE_H
