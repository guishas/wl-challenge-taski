import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';
import 'package:wl_challenge_taski/ui/todos/bloc/todos_bloc.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            RichText(
              text: TextSpan(
                text: 'Welcome, ',
                style: TextStyle(
                  color: AppColors.slatePurple,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: 'John',
                    style: TextStyle(
                      color: AppColors.mainBlue,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: '.',
                    style: TextStyle(
                      color: AppColors.slatePurple,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<TodosBloc, TodosState>(
              builder: (context, state) {
                return Text(
                  state.tasks.isEmpty ? 'Create tasks to achieve more' : 'You\'ve got ${state.tasks.length} ${state.tasks.length == 1 ? 'task' : 'tasks'} to do.',
                  style: TextStyle(
                    color: AppColors.slateBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.2,
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
