#ifndef UNTITLED__WIDGET_H
#define UNTITLED__WIDGET_H

#include <QPushButton>
#include <QTextEdit>
#include <QUdpSocket>
#include <QVBoxLayout>
#include <QWidget>

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
    void CloseBtnClicked();
    void dataReceived();

private:
    Ui::Widget *ui;

    QTextEdit *ReceiveTextEdit;
    QPushButton *CloseBtn;
    QVBoxLayout *mainLayout;
    int port;
    QUdpSocket *udpSocket;
};


#endif//UNTITLED__WIDGET_H
