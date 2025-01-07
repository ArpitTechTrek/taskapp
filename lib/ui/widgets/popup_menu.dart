import 'package:flutter/material.dart';
import 'package:taskapp/model/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback editTaskCallback;
  final VoidCallback cancelOrDeleteCallback;

  const PopupMenu({
    required this.task,
    required this.editTaskCallback,
    required this.cancelOrDeleteCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'edit') {
          editTaskCallback();
        } else if (value == 'delete') {
          cancelOrDeleteCallback();
        }
      },
      itemBuilder: (context) => task.isDeleted == false
          ? [
              PopupMenuItem(
                value: 'edit',
                child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    label: const Text('Edit',
                        style: TextStyle(color: Colors.blue))),
              ),
              PopupMenuItem(
                  value: 'delete',
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever_rounded,
                        color: Colors.red),
                    label: const Text('Delete',
                        style: TextStyle(color: Colors.red)),
                  ))
            ]
          : [
              // PopupMenuItem(
              //   value: 'delete',
              //   child: TextButton.icon(
              //     onPressed: null,
              //     icon:  const Icon(Icons.delete_forever_sharp),
              //     label: const Text('Delete Forever'),)
              // )
            ],
    );
  }
}

// return PopupMenuButton(itemBuilder: task.isDeleted == false ? ((context)=>[
//       PopupMenuItem(
//         onTap: editTaskCallback,
//         child: TextButton.icon(
//           onPressed: null,
//           icon: const Icon(Icons.edit),
//           label: const Text('Edit')),
//       ),
//       PopupMenuItem(
//         onTap: cancelOrDeleteCallback,
//         child: TextButton.icon(
//           onPressed: null,
//           icon:  const Icon(Icons.delete_sharp),
//           label: const Text('Delete'),)
//       )
//     ]): (context)=>[
//       PopupMenuItem(
//         onTap: cancelOrDeleteCallback,
//         child: TextButton.icon(
//           onPressed: null,
//           icon:  const Icon(Icons.delete_forever_sharp),
//           label: const Text('Delete Forever'),)
//       )
//     ],
//   );
