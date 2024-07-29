/*
* - UserEntity is a class that contains the user's information.
* - userId is the unique id of the user.
* - username is the name of the user.
* - isReview is a boolean value that indicates whether the user is a reviewer or not.
* - This class is used to pass user information between layers.
* */
class UserEntity {
  final String userId;
  final String username;
  final bool isReview;

  UserEntity(
      {required this.userId, required this.username, required this.isReview});
}
