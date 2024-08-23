import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopyee/config/widgets/custom_button.dart';
import 'package:shopyee/config/widgets/image_view_page.dart';
import 'package:shopyee/config/widgets/navigation.dart';
import 'package:shopyee/config/widgets/toast_alert.dart';
import 'package:shopyee/provider/auth_provider/auth_provider.dart';
import 'package:shopyee/provider/image_picker_provider/image_picker_provider.dart';
import 'package:shopyee/provider/profile_provider/profile_provider.dart';
import 'package:shopyee/view/profile/shimmer_loading.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  Future<void> _showImagePickerDialog(
      BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  ref.read(imageProvider.notifier).pickImage(true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  ref.read(imageProvider.notifier).pickImage(false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showImagePickerDialogC(
      BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  ref.read(coverPictureProvider.notifier).pickImage(true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  ref.read(coverPictureProvider.notifier).pickImage(false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(profilePictureUpdateProvider, (previous, next) {
      if (next.isError) {
        Toasts.showFailure(context, next.errMessage);
      } else if (next.isSuccess) {
        Toasts.showSuccess(context, 'Profile Image Updated Successfully');
        ref.invalidate(getProfileProvider);
        ref.read(imageProvider.notifier).resetImage();
      }
    });
    ref.listen(coverPictureUpdateProvider, (previous, next) {
      if (next.isError) {
        Toasts.showFailure(context, next.errMessage);
      } else if (next.isSuccess) {
        Toasts.showSuccess(context, 'Cover Image Updated Successfully');
        ref.invalidate(getProfileProvider);
        ref.read(coverPictureProvider.notifier).resetImage();
      }
    });
    final updateProfilePicture = ref.watch(profilePictureUpdateProvider);
    final updateCoverPicture = ref.watch(coverPictureUpdateProvider);
    final userData = ref.watch(getProfileProvider);
    final pickedProfilePicture = ref.watch(imageProvider);
    final pickedCoverPicture = ref.watch(coverPictureProvider);
    final auth = ref.watch(userLoginProvider);

    return Scaffold(
      body: userData.isLoad
          ? const ShimmerLoading()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    // clipBehavior: Clip.none,
                    children: [
                      Stack(
                        children: [
                          Container(
                            // color: Colors.red,
                            height: 278.h,
                            width: double.infinity,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navigatePush(
                                        context,
                                        ImageViewPage(
                                            imgUrl: userData
                                                .userProfile.cover_image));
                                  },
                                  child: pickedCoverPicture != null
                                      ? Image.file(
                                          File(pickedCoverPicture.path),
                                          width: double.infinity,
                                          height: 220.h,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          userData.userProfile.cover_image,
                                          height: 220.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 12.r,
                            bottom: 70.r,
                            child: GestureDetector(
                              onTap: () {
                                _showImagePickerDialogC(context, ref);
                                debugPrint('$pickedCoverPicture');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8),
                                ),
                                child: Row(
                                  children: [
                                    const Text('Update Cover Photo'),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      Icons.edit,
                                      size: 14.r,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: 175.h,
                        left: 0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 95.h,
                                    width: 98.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.r),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        navigatePush(
                                            context,
                                            ImageViewPage(
                                                imgUrl: userData.userProfile
                                                    .profile_image));
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: pickedProfilePicture != null
                                            ? Image.file(
                                                File(pickedProfilePicture.path),
                                                width: 98.w,
                                                height: 95.h,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                userData
                                                    .userProfile.profile_image,
                                                width: 98.w,
                                                height: 95.h,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        _showImagePickerDialog(context, ref);
                                        debugPrint('$pickedProfilePicture');
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(6.w),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.7),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            size: 14.r,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData.userProfile.name,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userData.userProfile.email,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (pickedProfilePicture != null)
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: CustomButton(
                          isLoading: updateProfilePicture.isLoad,
                          onTap: () {
                            ref
                                .read(profilePictureUpdateProvider.notifier)
                                .updateProfilePicture(
                                    token: auth.user[0].token,
                                    image: pickedProfilePicture);
                          },
                          text: 'Update Profile Image'),
                    ),
                  if (pickedCoverPicture != null)
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: CustomButton(
                          isLoading: updateCoverPicture.isLoad,
                          onTap: () {
                            ref
                                .watch(coverPictureUpdateProvider.notifier)
                                .updateCoverPicture(
                                    token: auth.user[0].token,
                                    image: pickedCoverPicture);
                          },
                          text: 'Update Cover Image'),
                    )
                ],
              ),
            ),
    );
  }
}
