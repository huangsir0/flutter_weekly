

import 'package:flutter_weekly/common/utils/http_util.dart';

class BaseModel  {

  //持有网络请求实例,比如Dio 之类的实例
  var httpUtil=DioFactory.instance;

}

