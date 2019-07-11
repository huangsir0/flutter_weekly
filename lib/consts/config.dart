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
}