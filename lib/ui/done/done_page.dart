import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/utils/snackbar_helper.dart';
import 'package:wl_challenge_taski/ui/done/bloc/done_bloc.dart';
import 'package:wl_challenge_taski/ui/done/widgets/header.dart';
import 'package:wl_challenge_taski/ui/done/widgets/tasks_list.dart';
import 'package:wl_challenge_taski/ui/todos/bloc/todos_bloc.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoneBloc, DoneState>(
      listenWhen: (previous, current) => previous.fetchDoneTasksStatus != current.fetchDoneTasksStatus || previous.uncompleteTaskStatus != current.uncompleteTaskStatus || previous.deleteTaskStatus != current.deleteTaskStatus || previous.deleteAllTasksStatus != current.deleteAllTasksStatus,
      listener: (context, state) {
        if (state.fetchDoneTasksStatus == FetchDoneTasksStatus.failure) {
          showErrorSnackBar(context, 'Something went wrong.');
        } else if (state.uncompleteTaskStatus == UncompleteTaskStatus.success) {
          showSuccessSnackBar(context, 'Task uncompleted successfully.');

          context.read<TodosBloc>().add(const TodosRevalidateTasks());
        } else if (state.uncompleteTaskStatus == UncompleteTaskStatus.failure) {
          showErrorSnackBar(context, 'Something went wrong.');
        } else if (state.deleteTaskStatus == DeleteTaskStatus.success) {
          showSuccessSnackBar(context, 'Task deleted successfully.');
        } else if (state.deleteTaskStatus == DeleteTaskStatus.failure) {
          showErrorSnackBar(context, 'Something went wrong.');
        } else if (state.deleteAllTasksStatus == DeleteAllTasksStatus.success) {
          showSuccessSnackBar(context, 'All tasks deleted successfully.');
        } else if (state.deleteAllTasksStatus == DeleteAllTasksStatus.failure) {
          showErrorSnackBar(context, 'Something went wrong.');
        }
      },
      child: Column(
        spacing: 24,
        children: [
          const DoneHeader(),
          const DoneTasksList(),
        ],
      ),
    );
  }
}
