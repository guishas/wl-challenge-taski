part of 'create_bloc.dart';

enum CreateTaskStatus {
  initial,
  loading,
  success,
  failure,
}

final class CreateState extends Equatable {
  const CreateState({
    this.createTaskStatus = CreateTaskStatus.initial,
    this.title,
    this.description,
  });

  final CreateTaskStatus createTaskStatus;

  final String? title;
  final String? description;

  CreateState copyWith({
    CreateTaskStatus? createTaskStatus,
    String? title,
    String? description,
  }) {
    return CreateState(
      createTaskStatus: createTaskStatus ?? this.createTaskStatus,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        createTaskStatus,
        title,
        description,
      ];
}
