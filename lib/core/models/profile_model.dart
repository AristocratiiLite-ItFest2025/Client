import 'package:help_now_frontend/core/enums/is_verified.dart';

class ProfileModel {
  final String? avatarImage;
  final double money;
  final String email;
  final IsVerified verifiedType;
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
      verifiedType: IsVerified.values.firstWhere(
            (e) => e.toString().split('.').last == json['isVerified'],
        orElse: () => IsVerified.NGO,
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

  ProfileModel copyWith({
    String? avatarImage,
    double? money,
    String? email,
    IsVerified? verifiedType,
    String? username,
    int? id,
  }) {
    return ProfileModel(
      avatarImage: avatarImage ?? this.avatarImage,
      money: money ?? this.money,
      email: email ?? this.email,
      verifiedType: verifiedType ?? this.verifiedType,
      username: username ?? this.username,
      id: id ?? this.id,
    );
  }
}
