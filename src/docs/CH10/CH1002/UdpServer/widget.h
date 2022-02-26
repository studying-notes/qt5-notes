#ifndef UNTITLED__WIDGET_H
#define UNTITLED__WIDGET_H

#include <QWidget>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QVBoxLayout>
#include <QUdpSocket>
#include <QTimer>

QT_BEGIN_NAMESPACE
namespace Ui {
    class Widget;
}
QT_END_NAMESPACE

class Widget : public QWidget {
    Q_OBJECT

public:
    explicit Widget(QWidget *parent = nullptr);
    ~Widget() override;

public slots:
    void StartBtnClicked();
    void timeout();

private:
    Ui::Widget *ui;

    QLabel *TimerLabel;
    QLineEdit *TextLineEdit;
    QPushButton *StartBtn;
    QVBoxLayout *mainLayout;
    int port;
    bool isStarted;
    QUdpSocket *udpSocket;
    QTimer *timer;
};


#endif//UNTITLED__WIDGET_H
