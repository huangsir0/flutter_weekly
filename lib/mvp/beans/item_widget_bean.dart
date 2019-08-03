class ItemWidgetBean {
  String title;
  String imgUrl;
  String url;
  String author;
  String createTime;
  String description;

  ItemWidgetBean(
      {this.title,
        this.imgUrl,
        this.url,
        this.author,
        this.createTime,
        this.description});

  ItemWidgetBean.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imgUrl = json['imgUrl'];
    url = json['url'];
    author = json['author'];
    createTime = json['create_time'];
    description = json['description'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    data['url'] = this.url;
    data['author'] = this.author;
    data['create_time'] = this.createTime;
    data['description'] = this.description;
    return data;
  }
}