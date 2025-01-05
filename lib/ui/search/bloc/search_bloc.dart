import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wl_challenge_taski/data/interfaces/tasks_repository.dart';
import 'package:wl_challenge_taski/data/models/task.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.tasksRepository,
  }) : super(const SearchState()) {
    on<SearchInputSubmitted>(onInputSubmitted);
    on<SearchUpdateTaskCompleted>(onUpdateTaskCompleted);
    on<SearchClearTasks>(onClearTasks);
    on<SearchRevalidateTasks>(onRevalidateTasks);
  }

  final ITasksRepository tasksRepository;

  void onInputSubmitted(SearchInputSubmitted event, Emitter<SearchState> emit) async {
    emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.loading));

    try {
      final tasks = await tasksRepository.searchTasks(event.input);

      emit(state.copyWith(
        fetchTasksStatus: FetchTasksStatus.success,
        tasks: tasks,
        lastSearchInput: event.input,
      ));
    } catch (e) {
      emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.failure));
    }

    emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.initial));
  }

  void onUpdateTaskCompleted(SearchUpdateTaskCompleted event, Emitter<SearchState> emit) async {
    emit(state.copyWith(updateTaskStatus: UpdateTaskStatus.loading));

    try {
      await tasksRepository.completeTask(event.taskId, event.isCompleted ? 0 : 1);

      emit(state.copyWith(updateTaskStatus: UpdateTaskStatus.success));

      add(const SearchRevalidateTasks());
    } catch (e) {
      emit(state.copyWith(updateTaskStatus: UpdateTaskStatus.failure));
    }

    emit(state.copyWith(updateTaskStatus: UpdateTaskStatus.initial));
  }

  void onClearTasks(SearchClearTasks event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      fetchTasksStatus: FetchTasksStatus.initial,
      clearTasks: true,
    ));
  }

  void onRevalidateTasks(SearchRevalidateTasks event, Emitter<SearchState> emit) async {
    emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.loading));

    try {
      final tasks = await tasksRepository.searchTasks(state.lastSearchInput!);

      emit(state.copyWith(
        fetchTasksStatus: FetchTasksStatus.success,
        tasks: tasks,
      ));
    } catch (e) {
      emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.failure));
    }
  }
}
