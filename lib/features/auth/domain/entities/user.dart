class User {
  final int id;
  final String email;
  final String nickname;
  final String? profileImageUrl;
  final String role;
  final String provider;

  const User({
    required this.id,
    required this.email,
    required this.nickname,
    this.profileImageUrl,
    required this.role,
    required this.provider,
  });

  bool get isAdmin => role == 'ROLE_ADMIN';
}