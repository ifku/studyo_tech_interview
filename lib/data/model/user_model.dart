import 'package:studyo_tech_interview/domain/entity/user_entity.dart';

/*
* - UserModel is a class that extends UserEntity
* - It is used to convert the json data to the UserEntity object
* - It is used to convert the UserEntity object to the json data
* */
class UserModel extends UserEntity {
  UserModel(
      {required super.userId,
      required super.username,
      required super.isReview});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['userId'],
        username: json['username'],
        isReview: json['isReview']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'isReview': isReview,
    };
  }
}
