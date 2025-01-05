part of 'create_bloc.dart';

sealed class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object> get props => [];
}

final class CreateTaskTitleChanged extends CreateEvent {
  const CreateTaskTitleChanged({
    required this.title,
  });

  final String title;

  @override
  List<Object> get props => [title];
}

final class CreateTaskDescriptionChanged extends CreateEvent {
  const CreateTaskDescriptionChanged({
    required this.description,
  });

  final String description;

  @override
  List<Object> get props => [description];
}

final class CreateTaskButtonClicked extends CreateEvent {
  const CreateTaskButtonClicked();

  @override
  List<Object> get props => [];
}
