import 'package:flutter/material.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';

void showSuccessSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.mainBlueOpacity,
      content: Row(
        spacing: 10,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mainBlue,
            ),
            child: Icon(
              Icons.check_rounded,
              color: AppColors.paleWhite,
              size: 20,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              color: AppColors.slatePurple,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.2,
            ),
          )
        ],
      ),
    ),
  );
}

void showErrorSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.fireRedOpacity,
      content: Row(
        spacing: 10,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.fireRed,
            ),
            child: Icon(
              Icons.check_rounded,
              color: AppColors.paleWhite,
              size: 20,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              color: AppColors.slatePurple,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.2,
            ),
          )
        ],
      ),
    ),
  );
}
