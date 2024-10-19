import 'package:injectable/injectable.dart';

import '../../data/models/friend_model.dart';
import '../repositories/friend_repository.dart';

@injectable
class FriendUseCase {
  final FriendRepository repository;

  FriendUseCase({required this.repository});
  Future<bool> addFriend(FriendModel model) {
    return repository.addFriend(model);
  }

  Future<void> deleteFriend(FriendModel model) {
    return repository.deleteFriend(model);
  }
}
