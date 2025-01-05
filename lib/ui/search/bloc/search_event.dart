part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

final class SearchInputSubmitted extends SearchEvent {
  const SearchInputSubmitted({
    required this.input,
  });

  final String input;

  @override
  List<Object> get props => [input];
}

final class SearchUpdateTaskCompleted extends SearchEvent {
  const SearchUpdateTaskCompleted({
    required this.taskId,
    required this.isCompleted,
  });

  final int taskId;
  final bool isCompleted;

  @override
  List<Object> get props => [taskId, isCompleted];
}

final class SearchClearTasks extends SearchEvent {
  const SearchClearTasks();

  @override
  List<Object> get props => [];
}

final class SearchRevalidateTasks extends SearchEvent {
  const SearchRevalidateTasks();

  @override
  List<Object> get props => [];
}
