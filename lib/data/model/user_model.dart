import 'package:studyo_tech_interview/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.userId, required super.username, required super.isReview});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['userId'], username: json['username'], isReview: json['isReview']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'isReview': isReview,
    };
  }
}
