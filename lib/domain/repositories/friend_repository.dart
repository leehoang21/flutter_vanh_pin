import '../../data/models/friend_model.dart';

abstract class FriendRepository {
  Future<bool> addFriend(FriendModel model);
  Future<void> deleteFriend(FriendModel model);
}
