import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wl_challenge_taski/data/models/task.dart';
import 'package:wl_challenge_taski/data/repositories/tasks_repository.dart';

part 'done_event.dart';
part 'done_state.dart';

class DoneBloc extends Bloc<DoneEvent, DoneState> {
  DoneBloc({
    required this.tasksRepository,
  }) : super(const DoneState()) {
    on<DoneInitial>(onInitial);
    on<DoneUncompleteButtonClicked>(onUncompleteButtonClicked);
    on<DoneDeleteButtonClicked>(onDeleteButtonClicked);
    on<DoneDeleteAllButtonClicked>(onDeleteAllButtonClicked);
    on<DoneRevalidateTasks>(onRevalidateTasks);
  }

  final TasksRepository tasksRepository;

  void onInitial(DoneInitial event, Emitter<DoneState> emit) async {
    emit(state.copyWith(fetchDoneTasksStatus: FetchDoneTasksStatus.loading));

    try {
      final tasks = await tasksRepository.getTasks(1);

      emit(state.copyWith(
        fetchDoneTasksStatus: FetchDoneTasksStatus.success,
        tasks: tasks,
      ));
    } catch (e) {
      emit(state.copyWith(fetchDoneTasksStatus: FetchDoneTasksStatus.failure));
    }

    emit(state.copyWith(fetchDoneTasksStatus: FetchDoneTasksStatus.initial));
  }

  void onUncompleteButtonClicked(DoneUncompleteButtonClicked event, Emitter<DoneState> emit) async {
    emit(state.copyWith(uncompleteTaskStatus: UncompleteTaskStatus.loading));

    try {
      await tasksRepository.completeTask(event.taskId, 0);

      emit(state.copyWith(
        uncompleteTaskStatus: UncompleteTaskStatus.success,
      ));

      add(const DoneRevalidateTasks());
    } catch (e) {
      emit(state.copyWith(uncompleteTaskStatus: UncompleteTaskStatus.failure));
    }

    emit(state.copyWith(uncompleteTaskStatus: UncompleteTaskStatus.initial));
  }

  void onDeleteButtonClicked(DoneDeleteButtonClicked event, Emitter<DoneState> emit) async {
    emit(state.copyWith(deleteTaskStatus: DeleteTaskStatus.loading));

    try {
      await tasksRepository.deleteTask(event.taskId);

      emit(state.copyWith(
        deleteTaskStatus: DeleteTaskStatus.success,
      ));

      add(const DoneRevalidateTasks());
    } catch (e) {
      emit(state.copyWith(deleteTaskStatus: DeleteTaskStatus.failure));
    }

    emit(state.copyWith(deleteTaskStatus: DeleteTaskStatus.initial));
  }

  void onDeleteAllButtonClicked(DoneDeleteAllButtonClicked event, Emitter<DoneState> emit) async {
    emit(state.copyWith(deleteAllTasksStatus: DeleteAllTasksStatus.loading));

    try {
      for (Task task in state.tasks) {
        await tasksRepository.deleteTask(task.id!);
      }

      emit(state.copyWith(deleteAllTasksStatus: DeleteAllTasksStatus.success));

      add(const DoneRevalidateTasks());
    } catch (e) {
      emit(state.copyWith(deleteAllTasksStatus: DeleteAllTasksStatus.failure));
    }

    emit(state.copyWith(deleteAllTasksStatus: DeleteAllTasksStatus.initial));
  }

  void onRevalidateTasks(DoneRevalidateTasks event, Emitter<DoneState> emit) async {
    emit(state.copyWith(fetchDoneTasksStatus: FetchDoneTasksStatus.loading));

    try {
      final tasks = await tasksRepository.getTasks(1);

      emit(state.copyWith(
        fetchDoneTasksStatus: FetchDoneTasksStatus.success,
        tasks: tasks,
      ));
    } catch (e) {
      emit(state.copyWith(fetchDoneTasksStatus: FetchDoneTasksStatus.failure));
    }
  }
}
