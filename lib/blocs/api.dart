import 'package:flutter_weekly/blocs/widget_scene_blocs/models/item_widget_model.dart';
import 'package:flutter_weekly/common/utils/http_util.dart';
import 'package:flutter_weekly/consts/config.dart';

abstract class BaseApi{
//网络请求实例
  var request=DioFactory.instance;
}


class WidgetSceneApi extends BaseApi{
  Future<List<ItemWidgetModel>> fetchItemWidget() async{
    List result =await request.localGet(Config.widgets);
    return result.map((data){
      return ItemWidgetModel.fromJson(data);
    }).toList();
  }

}
