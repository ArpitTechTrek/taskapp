import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/model/task.dart';

class FirestoreRepository {
  //create task function
  static Future<void> createTask(Task task) async {
    try {
      objectbox.taskBox.put(task);
      await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .doc(task.id.toString())
          .set(task.toMap());
    } catch (e) {
      throw Exception("Failed to create task: $e.toString()");
    }
  }

  //get all tasks function
  static Future<List<Task>> getTasks() async {
    List<Task> allTasks = [];
    try {
      final data = await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .get();

      for (var task in data.docs) {
        final singleTask = Task.fromMap(task.data());
        allTasks.add(singleTask);
        objectbox.taskBox.put(singleTask);
      }
      return allTasks;
    } catch (e) {
      throw Exception("Failed to get tasks: $e.toString()");
    }
  }

  //update task function whether it is completed or not
  static Future<void> updateTask(Task task) async {
    try {
      objectbox.taskBox.put(task);
      await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .doc(task.id.toString())
          .update(task.toMap());
    } catch (e) {
      throw Exception("Failed to update task $e.toString()");
    }
  }

  //deleting the task from the datebase.
  static Future<void> deleteTask(Task task) async {
    try {
      objectbox.taskBox.remove(task.id);
      await FirebaseFirestore.instance
          .collection(GetStorage().read('email'))
          .doc(task.id.toString())
          .delete();
    } catch (e) {
      throw Exception("Failed to delete task: $e.toString()");
    }
  }
}
