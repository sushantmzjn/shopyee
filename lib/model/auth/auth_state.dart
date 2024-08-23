import 'package:shopyee/model/user/user.dart';

class AuthState {
  final bool isError;
  final String errMessage;
  final bool isSuccess;
  final bool isLoad;
  final List<User> user;

  AuthState({
    required this.errMessage,
    required this.isError,
    required this.isLoad,
    required this.isSuccess,
    required this.user
  });

  AuthState copyWith({
    bool? isError,
    String? errMessage,
    bool? isSuccess,
    bool? isLoad,
    List<User>? user,
  }) {
    return AuthState(
      errMessage: errMessage ?? this.errMessage,
      isError: isError ?? this.isError,
      isLoad: isLoad ?? this.isLoad,
      isSuccess: isSuccess ?? this.isSuccess,
      user: user ?? this.user
    );
  }
}
