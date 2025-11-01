import 'package:reel_lessons/modules/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:reel_lessons/modules/dashboard/data/models/categories_reponse.dart';
import 'package:reel_lessons/modules/dashboard/domain/entities/home_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository{

  @override
  Future<CategoriesResponse?> fetchCategories() async {
    final response = await DashboardDataSource.fetchCategories();
    return response;
  }

  @override
  Future<HomeEntity?> getHomeComponents() async {
    final response = await DashboardDataSource.fetchHomeComponents();
    if (response != null) {
      return response;
    }
    return null;
  }

}