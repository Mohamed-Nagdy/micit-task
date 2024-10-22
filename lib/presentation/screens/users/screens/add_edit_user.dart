import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/users.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../providers/users.dart';
import '../../../widgets/primary_form_field.dart';

class AddEditUserPage extends ConsumerStatefulWidget {
  const AddEditUserPage({required this.user, super.key});
  final UserData? user;
  static const routeName = '/add_edit_user';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddEditUserPageState();
}

class _AddEditUserPageState extends ConsumerState<AddEditUserPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  String avatar = Assets.avatars.values.first.path;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isAdd = true;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      firstName = TextEditingController(text: widget.user?.firstName);
      lastName = TextEditingController(text: widget.user?.lastName);
      email = TextEditingController(text: widget.user?.email);
      avatar = widget.user?.avatar ?? Assets.avatars.values.first.path;
      isAdd = false;
    }
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    super.dispose();
  }

  bool isEmail(String em) {
    const String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isAdd ? 'Add User' : 'Edit User'),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final image = Assets.avatars.values[index].path;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            avatar = image;
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                            color: avatar == image
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                          child: Image.asset(
                            image,
                          ),
                        ),
                      );
                    },
                    itemCount: Assets.avatars.values.length,
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryFormField(
                  controller: firstName,
                  hint: 'First Name',
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'First Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                PrimaryFormField(
                  controller: lastName,
                  hint: 'Last Name',
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Last Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                PrimaryFormField(
                  controller: email,
                  hint: 'Email',
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Email is required';
                    }
                    if (!isEmail(value ?? '')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    if (formKey.currentState?.validate() == true) {
                      if (isAdd) {
                        ref.read(usersProvider.notifier).addUser(
                              firstName.text,
                              lastName.text,
                              email.text,
                              avatar,
                            );
                        context.pop();
                        return;
                      }
                      ref.read(usersProvider.notifier).updateUser(
                            widget.user?.id ?? 0,
                            firstName.text,
                            lastName.text,
                            email.text,
                            avatar,
                          );
                      context.pop();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        isAdd ? 'Add' : 'Edit',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
