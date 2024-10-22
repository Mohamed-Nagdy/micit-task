import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/router/router.dart';
import 'firebase_options.dart';
import 'presentation/screens/auth/screens/login.dart';

void main() async {
  final appRouter = AppRouter().getRoutes(initialLocation: LoginPage.routeName);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MICITTask(
        appRouter: appRouter,
      ),
    ),
  );
}

class MICITTask extends StatefulWidget {
  const MICITTask({required this.appRouter, super.key});
  final GoRouter appRouter;

  @override
  State<MICITTask> createState() => _MICITTaskState();
}

class _MICITTaskState extends State<MICITTask> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MICIT Task',
      debugShowCheckedModeBanner: false,
      routerConfig: widget.appRouter,
      builder: (context, child) {
        return child!;
      },
    );
  }
}
