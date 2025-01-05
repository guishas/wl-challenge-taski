part of 'todos_bloc.dart';

enum FetchTasksStatus {
  initial,
  loading,
  success,
  failure,
}

enum CompleteTaskStatus {
  initial,
  loading,
  success,
  failure,
}

final class TodosState extends Equatable {
  const TodosState({
    this.fetchTasksStatus = FetchTasksStatus.initial,
    this.tasks = const [],
    this.limit = 15,
    this.page = 0,
    this.completeTaskStatus = CompleteTaskStatus.initial,
  });

  final FetchTasksStatus fetchTasksStatus;
  final List<Task> tasks;
  final int limit;
  final int page;

  final CompleteTaskStatus completeTaskStatus;

  TodosState copyWith({
    FetchTasksStatus? fetchTasksStatus,
    List<Task>? tasks,
    int? limit,
    int? page,
    CompleteTaskStatus? completeTaskStatus,
  }) {
    return TodosState(
      fetchTasksStatus: fetchTasksStatus ?? this.fetchTasksStatus,
      tasks: tasks ?? this.tasks,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      completeTaskStatus: completeTaskStatus ?? this.completeTaskStatus,
    );
  }

  @override
  List<Object> get props => [
        fetchTasksStatus,
        tasks,
        limit,
        page,
        completeTaskStatus,
      ];
}
