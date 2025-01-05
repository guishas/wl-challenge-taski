import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';
import 'package:wl_challenge_taski/data/models/task.dart';
import 'package:wl_challenge_taski/ui/search/bloc/search_bloc.dart';

class SearchTaskCard extends StatelessWidget {
  const SearchTaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.paleWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<SearchBloc>().add(SearchUpdateTaskCompleted(taskId: task.id!, isCompleted: task.isCompleted!));
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: task.isCompleted! ? AppColors.mutedAzure : Colors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: AppColors.mutedAzure,
                  width: 2,
                ),
              ),
              child: task.isCompleted!
                  ? Icon(
                      Icons.check_rounded,
                      color: AppColors.paleWhite,
                      size: 16,
                    )
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Flexible(
                child: Text(
                  task.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.slatePurple,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              if (task.description != null) ...[
                Flexible(
                  child: Text(
                    task.description!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.slateBlue,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
              Text(
                '${task.createdAt!.day}/${task.createdAt!.month}',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.slateBlue,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
