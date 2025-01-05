import 'package:flutter/material.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';

class NoResults extends StatelessWidget {
  const NoResults({super.key});

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
            'No result found.',
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
