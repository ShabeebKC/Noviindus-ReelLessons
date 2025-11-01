import 'package:reel_lessons/constants/string_constants.dart';
import 'package:reel_lessons/modules/authentication/domain/repositories/login_repository.dart';
import 'package:reel_lessons/utils/shared_utils.dart';

class LoginUseCase{
  final LoginRepository loginRepository;
  LoginUseCase(this.loginRepository);

  Future<bool> tryLogin(String phone) async {
    final loginStatus = await loginRepository.getLoginStatus(phone);
    if(!loginStatus.status && loginStatus.accessToken.isEmpty) return false;
    
    SharedUtils.setString(StringConstants.accessKey, loginStatus.accessToken);
    return true;
  }
}