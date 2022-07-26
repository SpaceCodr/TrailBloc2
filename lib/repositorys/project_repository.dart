import 'package:hive_flutter/adapters.dart';
import 'package:TrailApp/core/values/keys.dart';
import 'package:TrailApp/models/project.dart';
import 'package:TrailApp/models/task.dart';

class ProjectRepository {
  Future<List<Project>> getProjects(String boxName) async {
    final box = await Hive.openBox<Project>(boxName);

    return box.values.toList();
  }

  List<Task> getAllTasks(List<Project> projects) {
    final tasks = <Task>[];

    for (final project in projects) {
      tasks.addAll(project.tasks ?? []);
    }

    return tasks;
  }

  Future<List<Project>> getAllProjects() async {
    List<Project> projects = [];
    final boxes = [kProjectBox, kMainProjectBox];

    for (int i = 0; i < boxes.length; i++) {
      projects.addAll(await getProjects(boxes[i]));
    }

    return projects;
  }
}
