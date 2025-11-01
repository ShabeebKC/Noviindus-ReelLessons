import 'package:reel_lessons/modules/profile/domain/repositories/profile_repository.dart';
import '../../data/models/my_feed_response.dart';

class ProfileUseCase{
  final ProfileRepository repository;
  ProfileUseCase(this.repository);

  List<Results> myFeeds = [];
  bool isCompleted = false;

  fetchMyFeeds(int page) async {
    if(isCompleted) return myFeeds;

    final response = await repository.fetchMyFeeds(page);
    if(response?.next == null) {
      isCompleted = true;
      return myFeeds;
    }

    final List<Results> feeds = response?.results ??  [];
    if(feeds.isNotEmpty) myFeeds.addAll(feeds);
    return myFeeds;
  }
}