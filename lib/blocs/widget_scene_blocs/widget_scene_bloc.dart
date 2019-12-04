import 'package:rxdart/rxdart.dart';

import '../bloc.dart';
import '../repository.dart';
import 'models/item_widget_model.dart';

class WidgetSceneBloc implements BlocBase{
  final _repository=Repository();
  final _widgetSceneFetcher=PublishSubject<List<ItemWidgetModel>>();

  //单个条目数据
  final _widgetItemDataFetcher=PublishSubject<ItemWidgetModel>();

  //监听
  Observable<List<ItemWidgetModel>> get widgetItems=>_widgetSceneFetcher.stream;


  //监听单个ItemWidgetModel
  Observable<ItemWidgetModel> get itemDatas =>_widgetItemDataFetcher.stream;


  //投放一个实体类
  void dispatcherData(ItemWidgetModel data){
    _widgetItemDataFetcher.sink.add(data);
  }

  void fetchWidgetItems() async{
    List<ItemWidgetModel> itemWidgets =await _repository.fetchItemWidgets();
    _widgetSceneFetcher.sink.add(itemWidgets);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _widgetSceneFetcher?.close();
    _widgetItemDataFetcher?.close();
  }

}