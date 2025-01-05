part of 'todos_bloc.dart';

sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosInitial extends TodosEvent {
  const TodosInitial();

  @override
  List<Object> get props => [];
}

class TodosRefetchTasks extends TodosEvent {
  const TodosRefetchTasks();

  @override
  List<Object> get props => [];
}

class TodosCompleteTask extends TodosEvent {
  const TodosCompleteTask({
    required this.taskId,
  });

  final int taskId;

  @override
  List<Object> get props => [taskId];
}

class TodosRevalidateTasks extends TodosEvent {
  const TodosRevalidateTasks();

  @override
  List<Object> get props => [];
}
