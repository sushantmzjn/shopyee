class UserProfile {
  int id;
  String name;
  String email;
  String profile_image;
  String cover_image;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.profile_image,
    required this.cover_image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profile_image: json['profile_image'] ?? '',
      cover_image: json['cover_image'] ?? '',
    );
  }
}
