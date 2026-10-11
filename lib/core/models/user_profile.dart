class UserProfile {
  final String name;
  final String email;
  final String profilePictureUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.profilePictureUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    profilePictureUrl: (json['avatar'] ?? 'https://picsum.photos/150/150')
        .toString()
        .replaceAll(RegExp(r'[\[\]"]'), ''),
  );
}