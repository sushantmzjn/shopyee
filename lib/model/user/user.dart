import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String token;
  @HiveField(1)
  UserDetails userDetails;

  User({required this.token, required this.userDetails});

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"] ?? '',
        userDetails: UserDetails.fromJson(json["user"] ?? {}),
      );
}

@HiveType(typeId: 1)
class UserDetails extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String email;

  UserDetails({required this.id, required this.email});

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"] ?? 0,
        email: json["email"] ?? '',
      );
}
