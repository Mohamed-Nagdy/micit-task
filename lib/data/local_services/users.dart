import '../models/users.dart';
import '../utils/database_helper.dart';

class UsersLocalService {
  final databaseHelper = DatabaseHelper();

  Future<List<UserData>> bulkAddUsers(Map<String, dynamic>? resposne) async {
    await databaseHelper.bulkAddUsers(resposne?['data']);
    return await getUsers();
  }

  Future<List<UserData>> getUsers() async {
    final users = await databaseHelper.getUsers();
    return users.map((userData) => UserData.fromJson(userData)).toList();
  }

  Future<int> addUser(
    String firstName,
    String lastName,
    String email,
    String avatar,
  ) async {
    final id = await databaseHelper.addUser({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'avatar': avatar,
    });
    return id;
  }

  Future<void> updateUser(
    int id,
    String firstName,
    String lastName,
    String email,
    String avatar,
  ) async {
    await databaseHelper.updateUser({
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'avatar': avatar,
    });
  }

  Future<void> deleteUser(int id) async {
    await databaseHelper.deleteUser(id);
  }
}
