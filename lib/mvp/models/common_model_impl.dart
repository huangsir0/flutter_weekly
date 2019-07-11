import 'package:flutter_weekly/mvp/base/base_model.dart';
import 'package:flutter_weekly/mvp/beans/common_bean.dart';
import 'package:flutter_weekly/mvp/constract/commoncontract.dart';

class CommonModelImpl extends BaseModel implements ICommonModel {

  Future<List<CommonBean>> _getDatas(String url,int pageNum,int pageSize) async {
    List models;
    String targetUrl=url+'/'+pageSize.toString()+'/'+pageNum.toString();
    try {
      Map<String, dynamic> response = await httpUtil.get(targetUrl);

      models = response['results'];

    } catch (exception) {
      print(exception);
    }
    return models.map((model) {
      CommonBean data=new CommonBean.fromJson(model);
      return data;
    }).toList();
  }

  @override
  Future<List<CommonBean>> fetchDatas(String url, int pageNum, int pageSize) {
    // TODO: implement fetchDatas
    return _getDatas(url,pageNum,pageSize);
  }
}
