import 'package:flutter_weekly/mvp/base/base_model.dart';
import 'package:flutter_weekly/mvp/base/ibase_views.dart';


abstract class  IMainView extends IBaseView{

  ///数据成功加载
  void onLoadSuc(List<String> titles);


  ///数据加载失败
  void onLoadFail();

}



abstract class IMainModel extends BaseModel{

 Future<List<String>> fetchTitles(String url);

}
