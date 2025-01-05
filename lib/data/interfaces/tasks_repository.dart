import 'package:wl_challenge_taski/data/models/task.dart';

abstract class ITasksRepository {
  Future<List<Task>> getTasks(int completedOnly, {int? limit, int? offset});
  Future<void> createTask(Task task);
  Future<void> completeTask(int taskId, int completed);
  Future<void> deleteTask(int taskId);
  Future<List<Task>> searchTasks(String input);
}
