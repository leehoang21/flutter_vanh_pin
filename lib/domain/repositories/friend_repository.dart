import '../../data/models/friend_model.dart';

abstract class FriendRepository {
  Future<List<FriendModel>> get(FriendStatus status);
  Future<bool> addFriend(FriendModel model);
  Future<void> deleteFriend(String? id, String? authorId);
}
