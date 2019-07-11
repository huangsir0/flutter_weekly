

import 'base_model.dart';
import 'ibase_presenter.dart';
import 'ibase_views.dart';


 class BasePresenter<V extends IBaseView> implements IBasePresenter{

  BaseModel mModel;

  V mView;



  @override
  void init(IBaseView view) {
    // TODO: implement init
    this.mView=view;
    this.mModel=BaseModel();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    mModel=null;
    mModel=null;
  }

 }