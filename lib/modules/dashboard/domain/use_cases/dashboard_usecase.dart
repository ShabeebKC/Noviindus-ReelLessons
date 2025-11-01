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
    final List<String> videoUrls = [
      "https://fastly.noviindusdemosites.in/private/5077072-hd_720_1366_25fps.mp4",
      "https://fastly.noviindusdemosites.in/private/7014806-hd_720_1366_25fps.mp4",
      "https://fastly.noviindusdemosites.in/private/8464944-hd_1280_720_25fps.mp4"
    ];

    for (final feed in videoUrls) {
      final videoController = VideoPlayerController.networkUrl(
          Uri.parse(feed)
      );
      final chewieController = ChewieController(
        videoPlayerController: videoController,
        aspectRatio: videoController.value.aspectRatio,
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