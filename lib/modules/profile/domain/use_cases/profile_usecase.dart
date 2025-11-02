import 'package:reel_lessons/modules/profile/domain/repositories/profile_repository.dart';
import '../../data/models/my_feed_response.dart';

class ProfileUseCase{
  final ProfileRepository repository;
  ProfileUseCase(this.repository);

  Future<MyFeedResponse?> fetchMyFeeds(int page) async {
    final MyFeedResponse? response = await repository.fetchMyFeeds(page);
    return response;
  }
}