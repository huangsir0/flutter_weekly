
import 'ibase_views.dart';

abstract class IBasePresenter<V extends IBaseView>{

  //初始化
  void init(V view);


  //释放
  void dispose();
}