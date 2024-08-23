import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopyee/model/user/profile_update_state.dart';
import 'package:shopyee/model/user/user_profile.dart';
import 'package:shopyee/model/user/user_profile_state.dart';
import 'package:shopyee/provider/auth_provider/auth_provider.dart';
import 'package:shopyee/services/profile_services/profile_services.dart';

final getProfileProvider =
    StateNotifierProvider<ProfileProvider, UserProfileState>((ref) {
  final auth = ref.watch(userLoginProvider);
  return ProfileProvider(
      UserProfileState(
        errMessage: '',
        isError: false,
        isLoad: false,
        isSuccess: false,
        userProfile: UserProfile(
          id: 0,
          name: '',
          email: '',
          profile_image: '',
          cover_image: '',
        ),
      ),
      auth.user[0].token);
});

class ProfileProvider extends StateNotifier<UserProfileState> {
  String token;
  ProfileProvider(super.state, this.token) {
    getProfile(token: token);
  }

  Future<void> getProfile({required String token}) async {
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final res = await ProfileServices.getProfile(token: token);
    res.fold(
      (l) => state = state.copyWith(
          isLoad: false, isError: true, isSuccess: false, errMessage: l),
      (r) => state = state.copyWith(
          isLoad: false,
          isError: false,
          isSuccess: true,
          errMessage: '',
          userProfile: r),
    );
  }
}

final profilePictureUpdateProvider =
    StateNotifierProvider<UpdateProfileProvider, ProfileUpdateState>(
        (ref) => UpdateProfileProvider(
              ProfileUpdateState(
                errMessage: '',
                isError: false,
                isLoad: false,
                isSuccess: false,
              ),
            ));
final coverPictureUpdateProvider =
    StateNotifierProvider<UpdateProfileProvider, ProfileUpdateState>(
        (ref) => UpdateProfileProvider(
              ProfileUpdateState(
                errMessage: '',
                isError: false,
                isLoad: false,
                isSuccess: false,
              ),
            ));

class UpdateProfileProvider extends StateNotifier<ProfileUpdateState> {
  UpdateProfileProvider(super.state);

  //---------update profile picture-----
  Future<void> updateProfilePicture({
    required String token,
    required XFile image,
  }) async {
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final res =
        await ProfileServices.updateProfilePicture(token: token, image: image);
    res.fold(
      (l) => state = state.copyWith(
          isLoad: false, isError: true, isSuccess: false, errMessage: l),
      (r) => state = state.copyWith(
          isLoad: false, isError: false, isSuccess: r, errMessage: ''),
    );
  }

  //---------update profile picture-----
  Future<void> updateCoverPicture({
    required String token,
    required XFile image,
  }) async {
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final res =
        await ProfileServices.updateCoverPicture(token: token, image: image);
    res.fold(
      (l) => state = state.copyWith(
          isLoad: false, isError: true, isSuccess: false, errMessage: l),
      (r) => state = state.copyWith(
          isLoad: false, isError: false, isSuccess: r, errMessage: ''),
    );
  }
}
