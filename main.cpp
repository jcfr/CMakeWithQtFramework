

#include <QApplication>
#include <QPushButton>
#include <QVBoxLayout>
#include <QWebView>

int main(int argc, char*argv[])
{
  QApplication app(argc, argv);
  
  QWidget topLevel;
  QVBoxLayout * layout = new QVBoxLayout();
  topLevel.setLayout(layout);

  QPushButton * button = new QPushButton("Quit");
  layout->addWidget(button);
  
  QWebView * webView = new QWebView();
  webView->setUrl(QUrl("http://github.com"));
  layout->addWidget(webView);
  
  QObject::connect(button, SIGNAL(clicked()), &app, SLOT(quit()));

  topLevel.show();
  
  return app.exec();
}

