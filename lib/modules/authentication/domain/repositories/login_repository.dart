import 'package:reel_lessons/modules/authentication/domain/entities/login_entity.dart';

abstract class LoginRepository{
  Future<LoginEntity> getLoginStatus(String phone);
}