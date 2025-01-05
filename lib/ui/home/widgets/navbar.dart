import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';
import 'package:wl_challenge_taski/ui/create/create_page.dart';
import 'package:wl_challenge_taski/ui/home/cubit/home_cubit.dart';
import 'package:wl_challenge_taski/ui/todos/bloc/todos_bloc.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select<HomeCubit, HomeTab>((cubit) => cubit.state.tab);

    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: AppColors.mainBlue,
        unselectedItemColor: AppColors.mutedAzure,
        selectedLabelStyle: TextStyle(
          height: 1.2,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          height: 1.2,
          fontWeight: FontWeight.w600,
        ),
        iconSize: 24,
        elevation: 10,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedTab.index,
        onTap: (value) {
          if (value == 1) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              builder: (mcontext) => BlocProvider.value(
                value: context.read<TodosBloc>(),
                child: const CreatePage(),
              ),
            );

            return;
          }

          context.read<HomeCubit>().setTab(HomeTab.values[value]);
        },
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Icon(Icons.checklist_rounded),
            ),
            label: 'Todo',
          ),
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Icon(Icons.add_circle_outline_rounded),
            ),
            label: 'Create',
          ),
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Icon(Icons.search_rounded),
            ),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Icon(Icons.task_alt_rounded),
            ),
            label: 'Done',
          ),
        ],
      ),
    );
  }
}
