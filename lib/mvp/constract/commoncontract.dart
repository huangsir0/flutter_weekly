
import 'package:flutter_weekly/mvp/base/base_model.dart';
import 'package:flutter_weekly/mvp/base/ibase_views.dart';
import 'package:flutter_weekly/mvp/beans/common_bean.dart';

abstract class  ICommonView extends IBaseView{

  ///数据成功加载
  Future onLoadSuc(List<CommonBean> datas);


  ///数据加载失败
  void onLoadFail();

}



abstract class ICommonModel extends BaseModel{

  Future<List<CommonBean>> fetchDatas(String url,int pageNum,int pageSize);
}
