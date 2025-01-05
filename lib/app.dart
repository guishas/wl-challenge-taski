import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/config/router.dart';
import 'package:wl_challenge_taski/data/repositories/tasks_repository.dart';
import 'package:wl_challenge_taski/ui/home/home_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.tasksRepository,
  });

  final TasksRepository tasksRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: tasksRepository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taski',
        theme: ThemeData(
          fontFamily: 'Urbanist',
        ),
        onGenerateRoute: AppRoutes.generateRoutes,
        home: const HomePage(),
      ),
    );
  }
}
