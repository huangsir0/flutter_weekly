import 'package:flutter_weekly/mvp/base/base_model.dart';
import 'package:flutter_weekly/mvp/constract/maincontract.dart';

class MainModelImpl extends BaseModel implements IMainModel {
  @override
  Future<List<String>> fetchTitles(String url) {
    // TODO: implement fetchTitles
    return _getTitles(url);
  }

  Future<List<String>> _getTitles(String url) async {
    List<String> items = new List();
    try {
      Map<String, dynamic> response = await httpUtil.get(url);
      items = List.from(response['category']);
      return items;
    } catch (exception) {}
    return items;
  }
}
