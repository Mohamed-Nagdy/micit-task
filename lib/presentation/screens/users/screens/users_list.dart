import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../providers/users.dart';
import '../../../utils/alert_dialog_utils.dart';
import 'add_edit_user.dart';

class UsersList extends ConsumerStatefulWidget {
  const UsersList({super.key});
  static const routeName = '/users';

  @override
  ConsumerState<UsersList> createState() => _UsersListState();
}

class _UsersListState extends ConsumerState<UsersList> with AlertDialogMixin {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(usersProvider.notifier).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(usersProvider.select((v) => v.loading));
    final users = ref.watch(usersProvider.select((v) => v.users));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AddEditUserPage.routeName);
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Builder(
        builder: (context) {
          if (loading == true) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (users == null || users.isEmpty) {
            return const Text('No users found');
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  '${users[index].firstName} ${users[index].lastName}',
                ),
                subtitle: Text(
                  '${users[index].email}',
                ),
                leading: users[index].avatar?.startsWith('assets') ?? false
                    ? Image.asset(
                        '${users[index].avatar}',
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(),
                        width: 50,
                        height: 50,
                      )
                    : CachedNetworkImage(
                        imageUrl: '${users[index].avatar}',
                        errorWidget: (context, error, stackTrace) =>
                            const SizedBox(),
                        width: 50,
                        height: 50,
                      ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'Edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'Delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    switch (value) {
                      case 'Edit':
                        context.pushNamed(
                          AddEditUserPage.routeName,
                          extra: {'user': users[index]},
                        );
                        break;
                      case 'Delete':
                        showCupertinoAlertDialog(
                          context,
                          'Delete User',
                          'Are you sure you want to delete this user ?',
                          onCancel: () => context.pop(),
                          onConfirm: () async {
                            await ref
                                .read(usersProvider.notifier)
                                .deleteUser(users[index].id ?? 0);
                            context.pop();
                          },
                        );
                        break;
                      default:
                        break;
                    }
                  },
                ),
              );
            },
            itemCount: users.length,
          );
        },
      ),
    );
  }
}
