import 'base/base_presenter.dart';
import 'constract/commoncontract.dart';
import 'models/common_model_impl.dart';

class CommonPresenter extends BasePresenter<ICommonView> {
  //实例对象
  CommonModelImpl commonModelImpl = new CommonModelImpl();

  //加载数据
  void getDatas(String url, int pageNum, int pageSize) {
    this.mView.showLoading();
    this.commonModelImpl.fetchDatas(url, pageNum, pageSize).then((data) {
      this.mView.onLoadSuc(data);
    }).catchError((onError) {
      this.mView.onLoadFail();
    });
  }
}
