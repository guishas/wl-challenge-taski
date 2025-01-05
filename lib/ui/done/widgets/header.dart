import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';
import 'package:wl_challenge_taski/ui/done/bloc/done_bloc.dart';

class DoneHeader extends StatelessWidget {
  const DoneHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoneBloc, DoneState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Completed Tasks',
              style: TextStyle(
                color: AppColors.slatePurple,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                height: 1.2,
              ),
            ),
            if (state.tasks.isNotEmpty) ...[
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  context.read<DoneBloc>().add(const DoneDeleteAllButtonClicked());
                },
                child: Text(
                  'Delete all',
                  style: TextStyle(
                    color: AppColors.fireRed,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ),
            ]
          ],
        );
      },
    );
  }
}
