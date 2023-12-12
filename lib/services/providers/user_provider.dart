import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/user.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void setUser(UserModel user) {
    state = user;
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((ref) => UserNotifier());
