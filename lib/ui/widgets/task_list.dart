import 'package:flutter/material.dart';
import 'package:taskapp/models/task.dart';
import 'package:taskapp/ui/widgets/task_tile.dart';

class TaskLists extends StatelessWidget {
  const TaskLists({
    super.key,
    required this.tasksLists,
  });

  final List<Task> tasksLists;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasksLists.length,
        itemBuilder: (context, index) {
          final task = tasksLists[index];
          return ExpansionPanelList.radio(
            children: [
              ExpansionPanelRadio(
                value: task.id,
                headerBuilder: (context, isExpanded) => TaskTile(task: task),
                body: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          //const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          const EdgeInsets.only(bottom: 5, left: 10),
                      child: Text(
                        task.description,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                          fontSize: 16,
                          //color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
