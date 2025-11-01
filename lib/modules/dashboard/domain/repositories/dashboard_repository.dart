import 'package:reel_lessons/modules/dashboard/data/models/categories_reponse.dart';
import '../entities/home_entity.dart';

abstract class DashboardRepository{
  Future<CategoriesResponse?> fetchCategories();
  Future<HomeEntity?> getHomeComponents();
}