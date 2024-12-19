import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/models/task.dart';
import 'package:taskapp/ui/screens/edit_task_screen.dart';
import 'package:taskapp/ui/widgets/popup_menu.dart';

import '../../blocs/bloc_exports.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _onDeleteTask(BuildContext context, Task task) {
      context.read<TaskBloc>().add(DeleteTask(task: task));
      context.read<TaskBloc>().add(GetAllTasks());
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(
            oldTask: task,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(DateFormat()
                    .add_yMMMd()
                    .add_Hms()
                    .format(DateTime.parse(task.date))),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TaskBloc>().add(UpdateTask(task: task));
                        context.read<TaskBloc>().add(GetAllTasks());
                      }
                    : null,
              ),
              PopupMenu(
                  task: task,
                  cancelOrDeleteCallback: () =>_onDeleteTask(context, task),
                  editTaskCallback: () => _editTask(context)
                )
            ],
          ),
        ],
      ),
    );
  }
}
