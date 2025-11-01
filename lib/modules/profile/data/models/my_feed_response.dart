class MyFeedResponse {
  int? count;
  String? next;
  List<Results>? results;

  MyFeedResponse({this.count, this.next, this.results});

  MyFeedResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? description;
  String? image;
  String? video;
  String? createdAt;
  bool? follow;
  User? user;
  List<Null>? likes;
  List<Null>? dislikes;
  List<Null>? bookmarks;
  List<Null>? hide;

  Results(
      {this.id,
        this.description,
        this.image,
        this.video,
        this.createdAt,
        this.follow,
        this.user,
        this.likes,
        this.dislikes,
        this.bookmarks,
        this.hide});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    image = json['image'];
    video = json['video'];
    createdAt = json['created_at'];
    follow = json['follow'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['image'] = image;
    data['video'] = video;
    data['created_at'] = createdAt;
    data['follow'] = follow;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
