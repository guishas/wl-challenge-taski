import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/utils/snackbar_helper.dart';
import 'package:wl_challenge_taski/ui/done/bloc/done_bloc.dart';
import 'package:wl_challenge_taski/ui/todos/bloc/todos_bloc.dart';
import 'package:wl_challenge_taski/ui/todos/widgets/tasks_list.dart';
import 'package:wl_challenge_taski/ui/todos/widgets/welcome.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodosBloc, TodosState>(
      listenWhen: (previous, current) => previous.fetchTasksStatus != current.fetchTasksStatus || previous.completeTaskStatus != current.completeTaskStatus,
      listener: (context, state) {
        if (state.fetchTasksStatus == FetchTasksStatus.failure) {
          showErrorSnackBar(context, 'Something went wrong.');
        }
        if (state.completeTaskStatus == CompleteTaskStatus.success) {
          showSuccessSnackBar(context, 'Task completed successfully.');

          context.read<DoneBloc>().add(const DoneRevalidateTasks());
        } else if (state.completeTaskStatus == CompleteTaskStatus.failure) {
          showErrorSnackBar(context, 'Something went wrong.');
        }
      },
      builder: (context, state) {
        if (state.fetchTasksStatus == FetchTasksStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.fetchTasksStatus == FetchTasksStatus.failure) {
          return Center(
            child: Text('Erro'),
          );
        }

        return Column(
          spacing: 24,
          children: [
            const Welcome(),
            const TasksList(),
          ],
        );
      },
    );
  }
}
