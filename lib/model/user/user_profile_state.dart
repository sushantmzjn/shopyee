import 'package:shopyee/model/user/user_profile.dart';

class UserProfileState {
  final bool isError;
  final String errMessage;
  final bool isSuccess;
  final bool isLoad;
  final UserProfile userProfile;

  UserProfileState(
      {required this.errMessage,
      required this.isError,
      required this.isLoad,
      required this.isSuccess,
      required this.userProfile});

  UserProfileState copyWith({
    bool? isError,
    String? errMessage,
    bool? isSuccess,
    bool? isLoad,
    UserProfile? userProfile,
  }) {
    return UserProfileState(
      errMessage: errMessage ?? this.errMessage,
      isError: isError ?? this.isError,
      isLoad: isLoad ?? this.isLoad,
      isSuccess: isSuccess ?? this.isSuccess,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
