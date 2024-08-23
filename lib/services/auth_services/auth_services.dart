import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopyee/model/user/user.dart';
import 'package:shopyee/network/api_endpoints.dart';

class AuthServices {
  static Dio dio = Dio();

  //--------------user register------------
  static Future<Either<String, bool>> userRegister({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await dio.post(
        EndPoint.userRegister,
        data: {
          'name': fullName,
          'email': email,
          'password': password,
        },
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

  //---------- user login -------------
  static Future<Either<String, User>> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final res = await dio.post(
        EndPoint.userLogin,
        data: {
          'email': email,
          'password': password,
        },
      );
      final user = User.fromJson(res.data);

      //------------- saving user response -------
      final userData = Hive.box<User>('userBox');
      await userData.clear();
      final loginUserData = User(
          token: user.token,
          userDetails: UserDetails(
            id: user.userDetails.id,
            email: user.userDetails.email,
          ));
      await userData.add(loginUserData);
      return Right(user);
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

  //---------- token status -------------
  static Future<Either<String, bool>> checkToken(
      {required String token}) async {
    try {
      final response = await dio.get(
        EndPoint.checkToken,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        debugPrint('${response.data['message']}');
        return const Right(true);
      } else {
        return Left(' ${response.data['message']}');
      }
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
