import 'dart:developer';

import '../local_services/users.dart';
import '../models/users.dart';
import '../utils/http_service.dart';

class UsersRemoteService {
  final usersLocalService = UsersLocalService();

  Future<List<UserData>?> fetchUsers() async {
    try {
      final resposne = await httpService.get('https://reqres.in/api/users');
      if (resposne != null) {
        final users = await usersLocalService.bulkAddUsers(resposne);
        return users;
      }
    } catch (e) {
      log('Error in getting users $e');
      final users = await usersLocalService.getUsers();
      return users;
    }
    return null;
  }
}
