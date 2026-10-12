import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../network/api.dart';

import '../../../services/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  // تسجيل الدخول
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _authService.login(email: email, password: password);
      final profile = await _authService.getProfile();
      emit(AuthAuthenticated(profile));
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  // إنشاء حساب
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _authService.register(
        name: name,
        email: email,
        password: password,
      );
      emit(AuthRegistered());
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  // تحميل البروفايل
  Future<void> loadProfile() async {
    emit(AuthLoading());
    try {
      final profile = await _authService.getProfile();
      emit(AuthAuthenticated(profile));
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  // تسجيل خروج
  void logout() {
    _authService.logout();
    emit(AuthUnauthenticated());
  }
}