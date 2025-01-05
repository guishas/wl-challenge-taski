import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/data/repositories/tasks_repository.dart';
import 'package:wl_challenge_taski/ui/done/bloc/done_bloc.dart';
import 'package:wl_challenge_taski/ui/home/cubit/home_cubit.dart';
import 'package:wl_challenge_taski/ui/home/widgets/header.dart';
import 'package:wl_challenge_taski/ui/home/widgets/navbar.dart';
import 'package:wl_challenge_taski/ui/home/widgets/stack.dart';
import 'package:wl_challenge_taski/ui/todos/bloc/todos_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => TodosBloc(
            tasksRepository: context.read<TasksRepository>(),
          )..add(const TodosInitial()),
        ),
        BlocProvider(
          create: (context) => DoneBloc(
            tasksRepository: context.read<TasksRepository>(),
          )..add(const DoneInitial()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        child: Column(
          spacing: 16,
          children: [
            const Header(),
            const PageCarousel(),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
