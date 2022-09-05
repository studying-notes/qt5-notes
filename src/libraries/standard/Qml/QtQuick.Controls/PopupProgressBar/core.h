#ifndef POPUP_PROGRESS_BAR__CORE_H
#define POPUP_PROGRESS_BAR__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//POPUP_PROGRESS_BAR__CORE_H
