// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local_services/users.dart';
import '../data/models/users.dart';
import '../data/remote_service/users.dart';

class UsersNotifier extends StateNotifier<UsersState> {
  UsersNotifier() : super(UsersState());

  UsersRemoteService usersRemoteService = UsersRemoteService();
  UsersLocalService usersLocalService = UsersLocalService();

  Future<void> fetchUsers() async {
    state = state.copyWith(loading: true);

    try {
      final users = await usersRemoteService.fetchUsers();
      state = state.copyWith(loading: false, users: users);
    } on Exception {
      state = state.copyWith(loading: false);
      log('Failed to fetch users');
    }
  }

  Future<void> addUser(
    String firstName,
    String lastName,
    String email,
    String avatar,
  ) async {
    final id = await usersLocalService.addUser(
      firstName,
      lastName,
      email,
      avatar,
    );
    state.users = List.from([
      ...state.users ?? [],
      UserData(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          avatar: avatar),
    ]);
    state = state.copyWith();
  }

  Future<void> updateUser(
    int id,
    String firstName,
    String lastName,
    String email,
    String avatar,
  ) async {
    await usersLocalService.updateUser(
      id,
      firstName,
      lastName,
      email,
      avatar,
    );
    state.users = state.users
        ?.map(
          (user) => user.id == id
              ? UserData(
                  id: id,
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  avatar: avatar,
                )
              : user,
        )
        .toList();
    state = state.copyWith();
  }

  Future<void> deleteUser(int id) async {
    await usersLocalService.deleteUser(id);
    state.users = state.users?.where((user) => user.id != id).toList();
    state = state.copyWith();
  }
}

class UsersState {
  bool? loading;
  List<UserData>? users;

  UsersState({
    this.loading,
    this.users,
  });

  UsersState copyWith({
    bool? loading,
    List<UserData>? users,
  }) {
    return UsersState(
      loading: loading ?? this.loading,
      users: users ?? this.users,
    );
  }
}

final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>((ref) {
  return UsersNotifier();
});
