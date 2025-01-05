import 'package:wl_challenge_taski/data/models/task.dart';
import 'package:wl_challenge_taski/core/services/database.dart';
import 'package:wl_challenge_taski/data/interfaces/tasks_repository.dart';

class TasksRepository implements ITasksRepository {
  const TasksRepository({
    required this.databaseService,
  });

  final DatabaseService databaseService;

  @override
  Future<List<Task>> getTasks(int completedOnly, {int? limit, int? offset}) async {
    try {
      final tasks = await databaseService.database.query(
        'tasks',
        where: 'is_completed = ?',
        limit: limit,
        offset: offset,
        whereArgs: [completedOnly],
        orderBy: 'created_at DESC',
      );

      return tasks.map((t) => Task.fromJson(t)).toList();
    } catch (e) {
      throw Exception('Unable to fetch tasks');
    }
  }

  @override
  Future<void> createTask(Task task) async {
    try {
      await databaseService.database.insert('tasks', task.toJson());
    } catch (e) {
      throw Exception('Unable to create task');
    }
  }

  @override
  Future<void> completeTask(int taskId, int completed) async {
    try {
      await databaseService.database.update(
        'tasks',
        {'is_completed': completed},
        where: 'id = ?',
        whereArgs: [taskId],
      );
    } catch (e) {
      throw Exception('Unable to complete task');
    }
  }

  @override
  Future<void> deleteTask(int taskId) async {
    try {
      await databaseService.database.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [taskId],
      );
    } catch (e) {
      throw Exception('Unable to delete task');
    }
  }

  @override
  Future<List<Task>> searchTasks(String input) async {
    try {
      final searchQuery = '%$input%';

      final tasks = await databaseService.database.query(
        'tasks',
        where: 'title LIKE ? OR description LIKE ?',
        whereArgs: [searchQuery, searchQuery],
        orderBy: 'created_at DESC',
      );

      return tasks.map((t) => Task.fromJson(t)).toList();
    } catch (e) {
      throw Exception('Unable to search tasks');
    }
  }
}
