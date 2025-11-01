class HomeEntity {
  final List<CategoryEntity> categories;
  final List<ResultEntity> results;

  HomeEntity({
    required this.categories,
    required this.results,
  });
}

class CategoryEntity {
  final String id;
  final String title;

  CategoryEntity({
    required this.id,
    required this.title,
  });
}

class ResultEntity {
  final int id;
  final String description;
  final String image;
  final String video;
  final UserEntity user;

  ResultEntity({
    required this.id,
    required this.description,
    required this.image,
    required this.video,
    required this.user,
  });
}

class UserEntity {
  final int id;
  final String name;
  final String? image;

  UserEntity({
    required this.id,
    required this.name,
    this.image,
  });
}