part of 'done_bloc.dart';

sealed class DoneEvent extends Equatable {
  const DoneEvent();

  @override
  List<Object> get props => [];
}

final class DoneInitial extends DoneEvent {
  const DoneInitial();

  @override
  List<Object> get props => [];
}

final class DoneUncompleteButtonClicked extends DoneEvent {
  const DoneUncompleteButtonClicked({
    required this.taskId,
  });

  final int taskId;

  @override
  List<Object> get props => [taskId];
}

final class DoneDeleteButtonClicked extends DoneEvent {
  const DoneDeleteButtonClicked({
    required this.taskId,
  });

  final int taskId;

  @override
  List<Object> get props => [taskId];
}

final class DoneDeleteAllButtonClicked extends DoneEvent {
  const DoneDeleteAllButtonClicked();

  @override
  List<Object> get props => [];
}

final class DoneRevalidateTasks extends DoneEvent {
  const DoneRevalidateTasks();

  @override
  List<Object> get props => [];
}
