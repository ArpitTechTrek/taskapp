import 'package:flutter/material.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/model/task.dart';
import '../../blocs/bloc_exports.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextField(
            autofocus: true,
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var task = Task(
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateTime.now().toString(),
                    );
                    objectbox.taskBox.put(task);
                    context.read<TaskBloc>().add(CreateTask(task: task));
                    context.read<TaskBloc>().add(GetAllTasks());
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'))
            ],
          ),
        ],
      ),
    );
  }
}
