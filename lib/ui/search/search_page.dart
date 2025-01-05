import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/utils/snackbar_helper.dart';
import 'package:wl_challenge_taski/data/repositories/tasks_repository.dart';
import 'package:wl_challenge_taski/ui/search/bloc/search_bloc.dart';
import 'package:wl_challenge_taski/ui/search/widgets/search_textfield.dart';
import 'package:wl_challenge_taski/ui/search/widgets/tasks_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        tasksRepository: context.read<TasksRepository>(),
      ),
      child: SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listenWhen: (previous, current) => previous.fetchTasksStatus != current.fetchTasksStatus || previous.updateTaskStatus != current.updateTaskStatus,
      listener: (context, state) {
        if (state.fetchTasksStatus == FetchTasksStatus.failure) {
          showErrorSnackBar(context, 'Something went wrong.');
        } else if (state.updateTaskStatus == UpdateTaskStatus.success) {
          showSuccessSnackBar(context, 'Task updated successfully.');
        } else if (state.updateTaskStatus == UpdateTaskStatus.failure) {
          showErrorSnackBar(context, 'Something went wrong.');
        }
      },
      child: Column(
        spacing: 24,
        children: [
          SearchTextField(),
          TasksList(),
        ],
      ),
    );
  }
}
