import 'base/base_presenter.dart';
import 'constract/maincontract.dart';
import 'models/main_model_impl.dart';

class MainPresenter extends BasePresenter<IMainView> {
  //实例对象
  MainModelImpl mainModel = new MainModelImpl();

  //加载数据
  void initTitles(String url) {
    this.mView.showLoading();
    this.mainModel.fetchTitles(url).then((data) {
      this.mView.onLoadSuc(data);
    }).catchError((onError) {
      this.mView.onLoadFail();
    });
  }
}
