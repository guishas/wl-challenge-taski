part of 'search_bloc.dart';

enum FetchTasksStatus {
  initial,
  loading,
  success,
  failure,
}

enum UpdateTaskStatus {
  initial,
  loading,
  success,
  failure,
}

final class SearchState extends Equatable {
  const SearchState({
    this.fetchTasksStatus = FetchTasksStatus.initial,
    this.tasks = const [],
    this.lastSearchInput,
    this.updateTaskStatus = UpdateTaskStatus.initial,
  });

  final FetchTasksStatus fetchTasksStatus;
  final List<Task> tasks;
  final String? lastSearchInput;
  final UpdateTaskStatus updateTaskStatus;

  SearchState copyWith({
    FetchTasksStatus? fetchTasksStatus,
    List<Task>? tasks,
    String? lastSearchInput,
    UpdateTaskStatus? updateTaskStatus,
    bool clearTasks = false,
  }) {
    return SearchState(
      fetchTasksStatus: fetchTasksStatus ?? this.fetchTasksStatus,
      tasks: clearTasks ? [] : (tasks ?? this.tasks),
      lastSearchInput: lastSearchInput ?? this.lastSearchInput,
      updateTaskStatus: updateTaskStatus ?? this.updateTaskStatus,
    );
  }

  @override
  List<Object?> get props => [
        fetchTasksStatus,
        tasks,
        lastSearchInput,
        updateTaskStatus,
      ];
}
