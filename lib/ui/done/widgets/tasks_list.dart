import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';
import 'package:wl_challenge_taski/ui/done/bloc/done_bloc.dart';

class DoneTasksList extends StatelessWidget {
  const DoneTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoneBloc, DoneState>(
      builder: (context, state) {
        if (state.tasks.isEmpty) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Image.asset('assets/images/no-data.png'),
                Text(
                  'You have no task completed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.slateBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: state.tasks.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.paleWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                spacing: 10,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      context.read<DoneBloc>().add(DoneUncompleteButtonClicked(taskId: state.tasks[index].id!));
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.mutedAzure,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        color: AppColors.paleWhite,
                        size: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.tasks[index].title!,
                          style: TextStyle(
                            color: AppColors.slateBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.2,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            context.read<DoneBloc>().add(DoneDeleteButtonClicked(taskId: state.tasks[index].id!));
                          },
                          child: Icon(
                            Icons.delete_rounded,
                            color: AppColors.fireRed,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
        );
      },
    );
  }
}
