import '../../domain/entities/home_entity.dart';

class HomeResponse extends HomeEntity {
  HomeResponse({
    required List<CategoryDict> categoryDict,
    required List<Results> results,
  }) : super(categories: categoryDict, results: results);

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    final categoryList = (json['category_dict'] as List?)
        ?.map((e) => CategoryDict.fromJson(e)).toList() ?? [];

    final resultList = (json['results'] as List?)?.map((e) => Results.fromJson(e)).toList() ?? [];

    return HomeResponse(
      categoryDict: categoryList,
      results: resultList,
    );
  }
}

class CategoryDict extends CategoryEntity {
  CategoryDict({
    required super.id,
    required super.title,
  });

  factory CategoryDict.fromJson(Map<String, dynamic> json) {
    return CategoryDict(
      id: json['id'].toString(),
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };
}

class Results extends ResultEntity {
  Results({
    required super.id,
    required super.description,
    required super.image,
    required super.video,
    required super.user,
    required super.createdAt,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      video: /*json['video'] ?? ''*/ 'https://fastly.noviindusdemosites.in/private/5077072-hd_720_1366_25fps.mp4',
      user: User.fromJson(json['user']),
      createdAt: json['created_at'] ?? '',
    );
  }
}

class User extends UserEntity {
  User({
    required super.id,
    required super.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}