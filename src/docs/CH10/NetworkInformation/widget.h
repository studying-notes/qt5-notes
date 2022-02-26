#ifndef UNTITLED__WIDGET_H
#define UNTITLED__WIDGET_H

#include <QWidget>
#include <QLabel>
#include <QPushButton>
#include <QLineEdit>
#include <QGridLayout>
#include <QMessageBox>
#include <QHostInfo>
#include <QNetworkInterface>

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

    void getHostInformation();

public slots:
    void slotDetail();

private:
    Ui::Widget *ui;

    QLabel *hostLabel;
    QLineEdit *LineEditLocalHostName;
    QLabel *ipLabel;
    QLineEdit *LineEditAddress;
    QPushButton *detailBtn;
    QGridLayout *mainLayout;
};


#endif//UNTITLED__WIDGET_H
