enum VerifiedType { person, ngo}

class ProfileModel {
  final String? avatarImage;
  final double money;
  final String email;
  final VerifiedType verifiedType;
  final String username;
  final int id;

  ProfileModel({
    required this.avatarImage,
    required this.money,
    required this.email,
    required this.verifiedType,
    required this.username,
    required this.id,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      avatarImage: json['avatar_image'] as String?,
      money: (json['bani_sold'] as num?)?.toDouble() ?? 0.0,
      email: json['email'].toString(),
      verifiedType: VerifiedType.values.firstWhere(
            (e) => e.toString().split('.').last == json['isVerified'],
        orElse: () => VerifiedType.person,
      ),
      username: json['username'].toString(),
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar_image': avatarImage,
      'bani_sold': money,
      'email': email,
      'isVerified': verifiedType.toString().split('.').last,
      'username': username,
      'id': id,
    };
  }
}
