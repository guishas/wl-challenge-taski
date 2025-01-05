part of 'done_bloc.dart';

enum FetchDoneTasksStatus {
  initial,
  loading,
  success,
  failure,
}

enum UncompleteTaskStatus {
  initial,
  loading,
  success,
  failure,
}

enum DeleteTaskStatus {
  initial,
  loading,
  success,
  failure,
}

enum DeleteAllTasksStatus {
  initial,
  loading,
  success,
  failure,
}

final class DoneState extends Equatable {
  const DoneState({
    this.fetchDoneTasksStatus = FetchDoneTasksStatus.initial,
    this.tasks = const [],
    this.uncompleteTaskStatus = UncompleteTaskStatus.initial,
    this.deleteTaskStatus = DeleteTaskStatus.initial,
    this.deleteAllTasksStatus = DeleteAllTasksStatus.initial,
  });

  final FetchDoneTasksStatus fetchDoneTasksStatus;
  final List<Task> tasks;

  final UncompleteTaskStatus uncompleteTaskStatus;
  final DeleteTaskStatus deleteTaskStatus;
  final DeleteAllTasksStatus deleteAllTasksStatus;

  DoneState copyWith({
    FetchDoneTasksStatus? fetchDoneTasksStatus,
    List<Task>? tasks,
    UncompleteTaskStatus? uncompleteTaskStatus,
    DeleteTaskStatus? deleteTaskStatus,
    DeleteAllTasksStatus? deleteAllTasksStatus,
  }) {
    return DoneState(
      fetchDoneTasksStatus: fetchDoneTasksStatus ?? this.fetchDoneTasksStatus,
      tasks: tasks ?? this.tasks,
      uncompleteTaskStatus: uncompleteTaskStatus ?? this.uncompleteTaskStatus,
      deleteTaskStatus: deleteTaskStatus ?? this.deleteTaskStatus,
      deleteAllTasksStatus: deleteAllTasksStatus ?? this.deleteAllTasksStatus,
    );
  }

  @override
  List<Object> get props => [
        fetchDoneTasksStatus,
        tasks,
        uncompleteTaskStatus,
        deleteTaskStatus,
        deleteAllTasksStatus,
      ];
}
