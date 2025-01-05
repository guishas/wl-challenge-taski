import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/ui/todos/bloc/todos_bloc.dart';
import 'package:wl_challenge_taski/ui/todos/widgets/empty_tasks.dart';
import 'package:wl_challenge_taski/ui/todos/widgets/task_card.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<TodosBloc>().add(const TodosRefetchTasks());
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state.tasks.isEmpty) {
          return const EmptyTasks();
        }

        return Flexible(
          child: ListView.separated(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              return TaskCard(task: state.tasks[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
          ),
        );
      },
    );
  }
}
