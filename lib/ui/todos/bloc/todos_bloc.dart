import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wl_challenge_taski/data/models/task.dart';
import 'package:wl_challenge_taski/data/interfaces/tasks_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({
    required this.tasksRepository,
  }) : super(const TodosState()) {
    on<TodosInitial>(onInitial);
    on<TodosRefetchTasks>(onRefetchTasks);
    on<TodosCompleteTask>(onCompleteTask);
    on<TodosRevalidateTasks>(onRevalidateTasks);
  }

  final ITasksRepository tasksRepository;

  void onInitial(TodosInitial event, Emitter<TodosState> emit) async {
    emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.loading));

    try {
      final tasks = await tasksRepository.getTasks(
        0,
        limit: state.limit,
      );

      log(tasks.toString());

      emit(state.copyWith(
        fetchTasksStatus: FetchTasksStatus.success,
        tasks: tasks,
        page: state.page + 1,
      ));
    } catch (e) {
      emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.failure));
    }

    emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.initial));
  }

  void onRefetchTasks(TodosRefetchTasks event, Emitter<TodosState> emit) async {
    emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.loading));

    try {
      final tasks = await tasksRepository.getTasks(
        0,
        limit: state.limit,
        offset: state.page * state.limit,
      );

      log(tasks.toString());

      final newTasks = List<Task>.from(tasks);

      emit(state.copyWith(
        fetchTasksStatus: FetchTasksStatus.success,
        tasks: [...state.tasks, ...newTasks],
        page: state.page + 1,
      ));
    } catch (e) {
      emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.failure));
    }

    emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.initial));
  }

  void onCompleteTask(TodosCompleteTask event, Emitter<TodosState> emit) async {
    emit(state.copyWith(completeTaskStatus: CompleteTaskStatus.loading));

    try {
      await tasksRepository.completeTask(event.taskId, 1);

      emit(state.copyWith(completeTaskStatus: CompleteTaskStatus.success));

      add(const TodosRevalidateTasks());
    } catch (e) {
      emit(state.copyWith(completeTaskStatus: CompleteTaskStatus.failure));
    }

    emit(state.copyWith(completeTaskStatus: CompleteTaskStatus.loading));
  }

  void onRevalidateTasks(TodosRevalidateTasks event, Emitter<TodosState> emit) async {
    try {
      final tasks = await tasksRepository.getTasks(
        0,
        limit: state.page > 0 ? state.page * state.limit : state.limit,
      );

      emit(state.copyWith(
        tasks: tasks,
      ));
    } catch (e) {
      log('Unable to revalidate tasks');
    }
  }
}
