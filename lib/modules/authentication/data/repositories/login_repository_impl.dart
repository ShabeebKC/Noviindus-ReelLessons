import 'package:reel_lessons/modules/authentication/data/data_source/login_data_source.dart';
import 'package:reel_lessons/modules/authentication/domain/entities/login_entity.dart';
import 'package:reel_lessons/modules/authentication/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{

  @override
  Future<LoginEntity> getLoginStatus(String phone) async {
    final response = await LoginDataSource.login(phone);
    return LoginEntity(
      status: response?.status ?? false,
      accessToken: response?.token?.access ?? '',
    );
  }

}