import 'package:flutter/material.dart';
import 'package:wl_challenge_taski/app.dart';
import 'package:wl_challenge_taski/core/services/database.dart';
import 'package:wl_challenge_taski/data/repositories/tasks_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final databaseService = DatabaseService();
  await databaseService.initialize();

  final tasksRepository = TasksRepository(databaseService: databaseService);

  runApp(App(
    tasksRepository: tasksRepository,
  ));
}
