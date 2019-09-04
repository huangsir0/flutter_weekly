import 'api.dart';
import 'widget_scene_blocs/models/item_widget_model.dart';

class Repository {
  final widgetSceneApi = new WidgetSceneApi();

  //获取数据
  Future<List<ItemWidgetModel>> fetchItemWidgets() =>
      widgetSceneApi.fetchItemWidget();
}
