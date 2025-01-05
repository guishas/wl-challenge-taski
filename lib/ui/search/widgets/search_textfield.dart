import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';
import 'package:wl_challenge_taski/ui/search/bloc/search_bloc.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  bool isFocused = false;
  void _focusListener() {
    setState(() {
      isFocused = focusNode.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();

    focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.removeListener(_focusListener);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: (value) {
        setState(() {});

        if (value.isEmpty) {
          context.read<SearchBloc>().add(const SearchClearTasks());
        }
      },
      onSubmitted: (value) {
        context.read<SearchBloc>().add(SearchInputSubmitted(input: controller.text.trim()));
      },
      cursorColor: AppColors.mainBlue,
      cursorHeight: 20,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        filled: true,
        fillColor: AppColors.paleWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.mainBlue,
          ),
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: isFocused ? AppColors.mainBlue : AppColors.slateBlue,
          size: 28,
        ),
        suffixIcon: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.clear();

            context.read<SearchBloc>().add(const SearchClearTasks());

            setState(() {});
          },
          child: Container(
            height: 8,
            width: 8,
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: controller.text.isNotEmpty ? AppColors.mutedAzure : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close_outlined,
              size: 16,
              color: controller.text.isNotEmpty ? AppColors.paleWhite : Colors.transparent,
            ),
          ),
        ),
        hintText: 'Search here...',
        hintStyle: TextStyle(
          color: AppColors.mutedAzure,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 1.2,
        ),
      ),
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
