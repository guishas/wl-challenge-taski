import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';
import 'package:wl_challenge_taski/ui/create/create_page.dart';
import 'package:wl_challenge_taski/ui/todos/bloc/todos_bloc.dart';

class EmptyTasks extends StatelessWidget {
  const EmptyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Image.asset('assets/images/no-data.png'),
          Text(
            'You have no task listed.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.slateBlue,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                builder: (mcontext) => BlocProvider.value(
                  value: context.read<TodosBloc>(),
                  child: const CreatePage(),
                ),
              );

              if (!context.mounted) return;

              context.read<TodosBloc>().add(const TodosRevalidateTasks());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainBlueOpacity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_rounded,
                  size: 24,
                  color: AppColors.mainBlue,
                ),
                Text(
                  'Create task',
                  style: TextStyle(
                    color: AppColors.mainBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
