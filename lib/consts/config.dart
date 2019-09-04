class Config{

  static const String baseUrl="http://gank.io/api/";

  ///链接超时时间
  static const int connectTimeout=8000;

  ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
  ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
  ///  注意: 这并不是接收数据的总时限.
  static const int receiveTimeout=3000;

  ///普通格式的header
  static const Map<String, dynamic> headers = {
    "Accept": "application/json",
  };

  ///json格式的header
  static const Map<String, dynamic> headersJson = {
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  };

  //数据加载URL

  static const today='today';

  //Android 数据
  static const commonData='data/';


  //widgets配置信息
  static const widgets="widgets";
}


class PageRoutes{
  ///Text 控件
  static final String widgetTextPage="/WidgetTextPage";
  ///Container控件
  static final String widgetContainerPage="/WidgetContainerPage";
  ///Stack控件
  static final String widgetStackPage="/WidgetStackPage";
  ///Column & Row 控件
  static final String widgetColumnAndRowPage="/WidgetColumnAndRowPage";
  ///TextField 控件
  static final String widgetTextFieldPage="/WidgetTextFieldPage";
  ///画笔时钟控件
  static final String widgetPainterTimeClockPage="/WidgetPainterTimeClockPage";
  ///贝塞尔演示
  static final String widgetBezierGesturePage="/WidgetBezierGesturePage";
  ///贝塞尔水波纹进度球
  static final String widgetCircleProgressPage="/WidgetCircleProgressPage";
  ///贝塞尔循环粘性小球
  static final String widgetBezierThemePage="/WidgetBezierThemePage";
}