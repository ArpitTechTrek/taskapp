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
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasksLists
              .map(
                (task) => ExpansionPanelRadio(
                  value: task.id,
                  headerBuilder: (context, isExpanded) => TaskTile(task: task),
                  body: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    //visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    //dense: true,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Description of the task is displayed here
                        Expanded(
                          child: Text(
                                task.description,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                        ),
                          
                        ]),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
