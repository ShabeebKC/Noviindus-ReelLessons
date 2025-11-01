import 'package:reel_lessons/modules/profile/data/data_source/profile_data_source.dart';
import 'package:reel_lessons/modules/profile/data/models/my_feed_response.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  @override
  Future<MyFeedResponse?> fetchMyFeeds(int page) async {
    final response = await ProfileDataSource.fetchMyFeeds(page);
    return response;
  }
}