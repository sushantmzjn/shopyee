import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopyee/main.dart';
import 'package:shopyee/model/auth/auth_state.dart';
import 'package:shopyee/model/auth/token_state.dart';
import 'package:shopyee/model/user/user.dart';
import 'package:shopyee/services/auth_services/auth_services.dart';

final userRegisterProvider = StateNotifierProvider<AuthProvider, AuthState>(
    (ref) => AuthProvider(AuthState(
        errMessage: '',
        isError: false,
        isLoad: false,
        isSuccess: false,
        user: ref.watch(box))));

final userLoginProvider = StateNotifierProvider<AuthProvider, AuthState>(
    (ref) => AuthProvider(AuthState(
        errMessage: '',
        isError: false,
        isLoad: false,
        isSuccess: false,
        user: ref.watch(box))));

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(super.state);

  //--------------user register------------
  Future<void> userRegister({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final res = await AuthServices.userRegister(
      fullName: fullName,
      email: email,
      password: password,
    );
    res.fold((l) {
      state = state.copyWith(
          isLoad: false, isError: true, isSuccess: false, errMessage: l);
    }, (r) {
      state = state.copyWith(
          isLoad: false, isError: false, isSuccess: r, errMessage: '');
    });
  }

  //------------ user login -----------
  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final res = await AuthServices.userLogin(email: email, password: password);
    res.fold((l) {
      state = state.copyWith(
          isLoad: false, isError: true, isSuccess: false, errMessage: l);
    }, (r) {
      state = state.copyWith(
          isLoad: false,
          isError: false,
          isSuccess: true,
          errMessage: '',
          user: [r]);
    });
  }

  //----------- user logout ----------
  void userLogOut() async {
    final box = Hive.box<User>('userBox');
    box.clear();
    state = state.copyWith(user: []);
  }
}

//-----------check token status----------

final checkTokenStatusProvider =
    StateNotifierProvider.family<TokenStateProvider, TokenState, String>(
        (ref, token) => TokenStateProvider(
            TokenState(
                errMessage: '',
                isError: false,
                isLoad: false,
                isSuccess: false),
            token));

class TokenStateProvider extends StateNotifier<TokenState> {
  String token;
  TokenStateProvider(super.state, this.token) {
    checkToken(token: token);
  }

  Future<void> checkToken({required String token}) async {
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final res = await AuthServices.checkToken(token: token);
    res.fold(
      (l) => state = state.copyWith(
          isLoad: false, isError: true, isSuccess: false, errMessage: l),
      (r) => state = state.copyWith(
          isLoad: false, isError: false, isSuccess: r, errMessage: ''),
    );
  }
}
