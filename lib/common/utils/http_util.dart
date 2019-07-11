import 'package:dio/dio.dart';
import 'package:flutter_weekly/consts/config.dart';


class DioFactory {
  static DioFactory get instance => _getInstance();
  static DioFactory _instance;

  Dio _dio;
  BaseOptions options;

  DioFactory._internal(
      {String basUrl = Config.baseUrl, Map<String, dynamic> header = Config.headers}) {
    options = new BaseOptions(
        baseUrl: basUrl,
        ///链接超时时间
        connectTimeout: 8000,
        ///[如果返回数据是json(content-type)，dio默认会自动将数据转为json，无需再手动转]
        responseType: ResponseType.json,
        receiveTimeout: 3000,
        headers: header);
    _dio = new Dio(options);
  }

  getDio() {
    return _dio;
  }

  static DioFactory _getInstance() {
    if (null == _instance) {
      _instance = new DioFactory._internal();
    }
    return _instance;
  }

  /// get 请求封装
  get(url,{ options, cancelToken, data}) async {
    print('get:::url：$url ,body: $data');
    Response response;
    try{
      response = await _dio.get(
          url,
          cancelToken:cancelToken
      );
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('get请求取消! ' + e.message);
      }else{
        print('get请求发生错误：$e');
      }
    }
    print(response.data.toString());
    return response.data;
  }


  /// post请求封装
  post(url,{ options, cancelToken, data}) async {
    print('post请求::: url：$url ,body: $data');
    Response response;
    try{
      response = await _dio.post(
          url,
          data:data !=null ? data : {},
          cancelToken:cancelToken
      );
      print(response);
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('get请求取消! ' + e.message);
      }else{
        print('get请求发生错误：$e');
      }
    }
    return response.data;
  }
}