#ifndef DIALOG_BUTTON_BOX__CORE_H
#define DIALOG_BUTTON_BOX__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//DIALOG_BUTTON_BOX__CORE_H
