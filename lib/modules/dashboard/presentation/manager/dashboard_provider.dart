import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:reel_lessons/modules/dashboard/domain/entities/home_entity.dart';
import 'package:reel_lessons/modules/dashboard/domain/use_cases/dashboard_usecase.dart';
import '../../data/models/categories_reponse.dart';

class DashboardProvider extends ChangeNotifier{
  final DashboardUseCase dashboardUseCase;
  DashboardProvider(this.dashboardUseCase);

  CategoriesResponse? categories;
  HomeEntity? homeComponents;

  int? _currentPlayingIndex;
  int? get currentPlayingIndex => _currentPlayingIndex;

  getCategories() async {
    categories = await dashboardUseCase.fetchCategories();
    notifyListeners();
  }

  getHomeComponents() async {
    homeComponents = await dashboardUseCase.fetchHomeComponents();
    if(homeComponents == null) return;
    homeComponents?.categories.sort((a, b) {
      final doubleA = double.tryParse(a.id) ?? 0;
      final doubleB = double.tryParse(b.id) ?? 0;
      return doubleA.compareTo(doubleB);
    });
    notifyListeners();
  }

  void playVideo(int index) async {
    if (_currentPlayingIndex != null && _currentPlayingIndex != index) {
      dashboardUseCase.chewieControllers[_currentPlayingIndex!].pause();
    }

    _currentPlayingIndex = index;
    await dashboardUseCase.videoControllers[index].initialize();
    dashboardUseCase.chewieControllers[index].play();
    notifyListeners();
  }

  void pauseCurrent() {
    if (_currentPlayingIndex != null) {
      dashboardUseCase.chewieControllers[_currentPlayingIndex!].pause();
      _currentPlayingIndex = null;
      notifyListeners();
    }
  }

  ChewieController getChewieController(int index) {
    return dashboardUseCase.chewieControllers[index];
  }
}