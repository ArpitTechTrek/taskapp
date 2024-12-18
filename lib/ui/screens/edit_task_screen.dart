import 'package:flutter/material.dart';
import 'package:taskapp/models/task.dart';
import '../../blocs/bloc_exports.dart';

class EditTaskScreen extends StatelessWidget {

  final Task oldTask;
  const EditTaskScreen({super.key, required this.oldTask});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: oldTask.title);
    TextEditingController descriptionController = TextEditingController(text: oldTask.description);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Edit Task',
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
                    var editedTask = Task(
                      title: titleController.text,
                      description: descriptionController.text,
                      date: DateTime.now().toString(),
                      id: oldTask.id,
                      isDone: false
                    );
                    context.read<TaskBloc>().add(EditTask(newTask: editedTask));
                    context.read<TaskBloc>().add(GetAllTasks());
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'))
            ],
          ),
        ],
      ),
    );
  }
}
