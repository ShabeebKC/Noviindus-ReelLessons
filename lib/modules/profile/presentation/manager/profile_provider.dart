import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:reel_lessons/modules/profile/domain/use_cases/profile_usecase.dart';
import 'package:video_player/video_player.dart';
import '../../data/models/my_feed_response.dart';

class ProfileProvider extends ChangeNotifier{
  final ProfileUseCase useCase;
  ProfileProvider(this.useCase);

  List<Results> myFeeds = [];
  bool isCompleted = false;

  int? _currentPlayingIndex;
  int? get currentPlayingIndex => _currentPlayingIndex;

  final List<VideoPlayerController> videoControllers = [];
  final List<ChewieController> chewieControllers = [];

  fetchMyFeeds(int page) async {
    if(isCompleted) return;

    final MyFeedResponse? response = await useCase.fetchMyFeeds(page);
    if(response?.next == null) isCompleted = true;

    final List<Results> feeds = response?.results ??  [];
    if(feeds.isNotEmpty) myFeeds.addAll(feeds);
    initControllers(myFeeds);
    notifyListeners();
  }

  VideoPlayerController getController(int index){
    return videoControllers[index];
  }

  void playVideo(int index) async {
    if (_currentPlayingIndex != null && _currentPlayingIndex != index) {
      chewieControllers[_currentPlayingIndex!].pause();
    }
    _currentPlayingIndex = index;
    await getController(index).initialize();
    chewieControllers[index].play();
    notifyListeners();
  }

  void pauseCurrent() {
    if (_currentPlayingIndex != null) {
      chewieControllers[_currentPlayingIndex!].pause();
      _currentPlayingIndex = null;
      notifyListeners();
    }
  }

  ChewieController getChewieController(int index) {
    return chewieControllers[index];
  }

  void initControllers(List<Results>? results) {
    videoControllers.clear();
    chewieControllers.clear();
    for (final feed in results ?? <Results>[]) {
      final videoController = VideoPlayerController.networkUrl(
          Uri.parse(feed.video ?? "")
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
