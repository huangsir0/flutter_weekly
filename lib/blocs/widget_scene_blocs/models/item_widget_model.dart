class ItemWidgetModel {
  String title;
  String imgUrl;
  String url;
  String author;
  String createTime;
  String dayTime;
  String pageRoute;
  String description;

  ItemWidgetModel(
      {this.title,
        this.imgUrl,
        this.url,
        this.author,
        this.createTime,
        this.dayTime,
        this.pageRoute,
        this.description});

  ItemWidgetModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imgUrl = json['imgUrl'];
    url = json['url'];
    author = json['author'];
    dayTime = json['daytime'];
    createTime = json['create_time'];
    pageRoute = json['pageRoute'];
    description = json['description'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    data['url'] = this.url;
    data['author'] = this.author;
    data['daytime'] = this.dayTime;
    data['create_time'] = this.createTime;
    data['pageRoute'] = this.pageRoute;
    data['description'] = this.description;
    return data;
  }
}