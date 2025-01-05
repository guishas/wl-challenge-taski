import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wl_challenge_taski/data/models/task.dart';
import 'package:wl_challenge_taski/data/interfaces/tasks_repository.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc({
    required this.tasksRepository,
  }) : super(const CreateState()) {
    on<CreateTaskTitleChanged>(onTitleChanged);
    on<CreateTaskDescriptionChanged>(onDescriptionChanged);
    on<CreateTaskButtonClicked>(onButtonClicked);
  }

  final ITasksRepository tasksRepository;

  void onTitleChanged(CreateTaskTitleChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void onDescriptionChanged(CreateTaskDescriptionChanged event, Emitter<CreateState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void onButtonClicked(CreateTaskButtonClicked event, Emitter<CreateState> emit) async {
    emit(state.copyWith(createTaskStatus: CreateTaskStatus.loading));

    try {
      final task = Task(
        title: state.title,
        description: state.description,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      await tasksRepository.createTask(task);

      emit(state.copyWith(createTaskStatus: CreateTaskStatus.success));
    } catch (e) {
      emit(state.copyWith(createTaskStatus: CreateTaskStatus.failure));
    }
  }
}
