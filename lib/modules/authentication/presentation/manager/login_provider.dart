import 'package:flutter/material.dart';
import '../../domain/use_cases/login_usecase.dart';

class LoginProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  LoginProvider(this.loginUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String phone) async {
    _isLoading = true;
    notifyListeners();

    final isLoggedIn = await loginUseCase.tryLogin(phone);
    _isLoading = false;
    notifyListeners();

    if (isLoggedIn) {
      return true;
    }
    return false;
  }
}