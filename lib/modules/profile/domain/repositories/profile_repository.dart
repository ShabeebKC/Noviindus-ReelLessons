import '../../data/models/my_feed_response.dart';

abstract class ProfileRepository{
  Future<MyFeedResponse?> fetchMyFeeds(int page);
}