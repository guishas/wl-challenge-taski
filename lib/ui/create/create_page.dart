import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wl_challenge_taski/core/config/colors.dart';
import 'package:wl_challenge_taski/core/utils/snackbar_helper.dart';
import 'package:wl_challenge_taski/data/repositories/tasks_repository.dart';
import 'package:wl_challenge_taski/ui/create/bloc/create_bloc.dart';
import 'package:wl_challenge_taski/ui/todos/bloc/todos_bloc.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateBloc(
        tasksRepository: context.read<TasksRepository>(),
      ),
      child: const CreateView(),
    );
  }
}

class CreateView extends StatelessWidget {
  const CreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocListener<CreateBloc, CreateState>(
      listenWhen: (previous, current) => previous.createTaskStatus != current.createTaskStatus,
      listener: (context, state) {
        if (state.createTaskStatus == CreateTaskStatus.success) {
          Navigator.pop(context);

          showSuccessSnackBar(context, 'Task created successfully.');

          context.read<TodosBloc>().add(const TodosRevalidateTasks());
        } else if (state.createTaskStatus == CreateTaskStatus.failure) {
          Navigator.pop(context);

          showErrorSnackBar(context, 'Something went wrong.');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 10,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: AppColors.mutedAzure,
                      width: 2,
                    ),
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    onChanged: (value) {
                      context.read<CreateBloc>().add(CreateTaskTitleChanged(title: value));
                    },
                    cursorColor: AppColors.slateBlue,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      hintStyle: TextStyle(
                        color: AppColors.mutedAzure,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1.2,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: Row(
                spacing: 10,
                children: [
                  Icon(
                    Icons.edit_rounded,
                    size: 24,
                    color: AppColors.mutedAzure,
                  ),
                  Flexible(
                    child: TextFormField(
                      onChanged: (value) {
                        context.read<CreateBloc>().add(CreateTaskDescriptionChanged(description: value));
                      },
                      cursorColor: AppColors.slateBlue,
                      cursorHeight: 20,
                      decoration: InputDecoration(
                        hintText: 'Add a note...',
                        hintStyle: TextStyle(
                          color: AppColors.mutedAzure,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.2,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<CreateBloc, CreateState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.createTaskStatus == CreateTaskStatus.loading
                      ? null
                      : () {
                          context.read<CreateBloc>().add(const CreateTaskButtonClicked());
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(size.width, 40),
                  ),
                  child: state.createTaskStatus == CreateTaskStatus.loading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeCap: StrokeCap.round,
                          ),
                        )
                      : Text(
                          'Create',
                          style: TextStyle(
                            color: AppColors.paleWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.2,
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
