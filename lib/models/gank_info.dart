class GankInfo {
  bool used;
  String id;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  String who;
  List<String> images;

  GankInfo.fromParams(
      {this.used,
      this.id,
      this.createdAt,
      this.desc,
      this.publishedAt,
      this.source,
      this.type,
      this.url,
      this.who,
      this.images});

  GankInfo.fromJson(jsonRes) {
    used = jsonRes['used'];
    id = jsonRes['_id'];
    createdAt = jsonRes['createdAt'];
    desc = jsonRes['desc'];
    publishedAt = jsonRes['publishedAt'];
    source = jsonRes['source'];
    type = jsonRes['type'];
    url = jsonRes['url'];
    who = jsonRes['who'];
    images = jsonRes['images'] == null ? null : [];

    for (var imagesItem in images == null ? [] : jsonRes['images']) {
      images.add(imagesItem);
    }
  }

}
