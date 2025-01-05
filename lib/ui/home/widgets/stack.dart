import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/ui/done/done_page.dart';
import 'package:wl_challenge_taski/ui/home/cubit/home_cubit.dart';
import 'package:wl_challenge_taski/ui/search/search_page.dart';
import 'package:wl_challenge_taski/ui/todos/todos_page.dart';

class PageCarousel extends StatelessWidget {
  const PageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select<HomeCubit, HomeTab>((cubit) => cubit.state.tab);

    return Expanded(
      child: IndexedStack(
        index: selectedTab.index,
        children: const [
          TodosPage(),
          Placeholder(),
          SearchPage(),
          DonePage(),
        ],
      ),
    );
  }
}
