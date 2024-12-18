import 'package:flutter/material.dart';
import 'package:taskapp/models/task.dart';

class PupupMenu extends StatelessWidget {


  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback editTaskCallback;

  const PupupMenu({
    required this.cancelOrDeleteCallback,
    required this.task,
    required this.editTaskCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return PopupMenuButton<String>(
      onSelected: (value) => {
        if(value == 'edit'){
          editTaskCallback()
        }else if(value == 'delete'){
          cancelOrDeleteCallback()
        }
      },
      itemBuilder: (context)=>task.isDeleted == false ? [
        PopupMenuItem(
          value: 'edit',
          child: TextButton.icon(
            onPressed: null, 
            icon: const Icon(Icons.edit),
            label: const Text('Edit')),
        ),
        PopupMenuItem(
          value: 'delete',
          child: TextButton.icon(
            onPressed: null, 
            icon:  const Icon(Icons.delete_sharp),
            label: const Text('Delete'),)
        )
      ]: [
        PopupMenuItem(
          value: 'delete',
          child: TextButton.icon(
            onPressed: null, 
            icon:  const Icon(Icons.delete_forever_sharp),
            label: const Text('Delete Forever'),)
        )
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