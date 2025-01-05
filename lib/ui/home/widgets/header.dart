import 'package:flutter/material.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Row(
            spacing: 10,
            children: [
              Image.asset('assets/images/logo.png'),
              Text(
                'Taski',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.slatePurple,
                  fontSize: 20,
                ),
              )
            ],
          ),
          const Spacer(),
          Row(
            spacing: 10,
            children: [
              Text(
                'John',
                style: TextStyle(
                  color: AppColors.slatePurple,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Image.asset('assets/images/avatar.png'),
            ],
          ),
        ],
      ),
    );
  }
}
