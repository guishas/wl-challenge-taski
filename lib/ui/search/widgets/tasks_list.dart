import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/ui/search/bloc/search_bloc.dart';
import 'package:wl_challenge_taski/ui/search/widgets/no_results.dart';
import 'package:wl_challenge_taski/ui/search/widgets/no_search.dart';
import 'package:wl_challenge_taski/ui/search/widgets/search_task_card.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.tasks.isEmpty && state.fetchTasksStatus == FetchTasksStatus.success) {
          return const NoResults();
        } else if (state.tasks.isEmpty && state.fetchTasksStatus == FetchTasksStatus.initial) {
          return const NoSearch();
        }

        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: state.tasks.length,
          itemBuilder: (context, index) {
            return SearchTaskCard(task: state.tasks[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        );
      },
    );
  }
}
