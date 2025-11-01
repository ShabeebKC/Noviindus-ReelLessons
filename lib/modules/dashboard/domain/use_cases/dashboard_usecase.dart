import 'package:reel_lessons/modules/dashboard/domain/entities/home_entity.dart';
import 'package:reel_lessons/modules/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:video_player/video_player.dart';
import '../../data/models/categories_reponse.dart';
import 'package:chewie/chewie.dart';

class DashboardUseCase{
  final DashboardRepository dashboardRepository;
  DashboardUseCase(this.dashboardRepository);

  final List<VideoPlayerController> videoControllers = [];
  final List<ChewieController> chewieControllers = [];

  Future<CategoriesResponse?> fetchCategories() async {
    final response = await dashboardRepository.fetchCategories();
    return response;
  }

  Future<HomeEntity?> fetchHomeComponents() async {
    final response = await dashboardRepository.getHomeComponents();
    initControllers(response?.results);
    return response;
  }

  void initControllers(List<ResultEntity>? results) {
    for (final feed in results ?? <ResultEntity>[]) {
      final videoController = VideoPlayerController.networkUrl(
          Uri.parse(feed.video)
      );
      final chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: false,
        looping: false,
        showControls: true,
        allowFullScreen: true,
      );
      videoControllers.add(videoController);
      chewieControllers.add(chewieController);
    }
  }
}