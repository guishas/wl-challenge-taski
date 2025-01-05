import 'package:flutter/material.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';

class NoSearch extends StatelessWidget {
  const NoSearch({super.key});

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
            'Search for completed and uncompleted tasks.',
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
}
