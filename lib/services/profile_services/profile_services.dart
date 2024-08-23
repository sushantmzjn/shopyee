import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopyee/model/user/user_profile.dart';
import 'package:shopyee/network/api_endpoints.dart';

class ProfileServices {
  static Dio dio = Dio();
  //-------- get profile ------------
  static Future<Either<String, UserProfile>> getProfile(
      {required String token}) async {
    try {
      final res = await dio.get(
        EndPoint.getProfile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final data = UserProfile.fromJson(res.data['user_data']);
      return Right(data);
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            'Error in getting data ${e.response!.statusCode} : ${e.response!.statusMessage}');
        return Left('${e.response!.data['message']}');
      } else {
        debugPrint('Error in getting data: ${e.message}');
        return Left('${e.message}');
      }
    }
  }

  //--------------- update profile picture ----------
  static Future<Either<String, bool>> updateProfilePicture({
    required String token,
    required XFile image,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'profile_image': await MultipartFile.fromFile(image.path),
      });
      await dio.post(
        EndPoint.updateProfile,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return const Right(true);
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            'Error in getting data ${e.response!.statusCode} : ${e.response!.statusMessage}');
        return Left('${e.response!.data['message']}');
      } else {
        debugPrint('Error in getting data: ${e.message}');
        return Left('${e.message}');
      }
    }
  }

  //--------------- update cover picture ----------
  static Future<Either<String, bool>> updateCoverPicture({
    required String token,
    required XFile image,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'cover_image': await MultipartFile.fromFile(image.path),
      });
      await dio.post(
        EndPoint.updateProfile,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return const Right(true);
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            'Error in getting data ${e.response!.statusCode} : ${e.response!.statusMessage}');
        return Left('${e.response!.data['message']}');
      } else {
        debugPrint('Error in getting data: ${e.message}');
        return Left('${e.message}');
      }
    }
  }
}
