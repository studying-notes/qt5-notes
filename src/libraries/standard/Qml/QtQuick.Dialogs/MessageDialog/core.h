#ifndef MESSAGE_DIALOG__CORE_H
#define MESSAGE_DIALOG__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//MESSAGE_DIALOG__CORE_H
