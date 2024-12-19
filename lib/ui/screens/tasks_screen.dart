import 'package:flutter/material.dart';
import 'package:taskapp/models/task.dart';
import 'package:taskapp/ui/screens/add_task_screen.dart';
import 'package:taskapp/ui/widgets/task_list.dart';
import '../../blocs/bloc_exports.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();

  static const id = 'tasks_screen';
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    context.read<TaskBloc>().add(GetAllTasks());
    super.initState();
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const AddTaskScreen(),
        ),
      ),
    );
  }

  int _getCompletedTasks(List<Task> tasksLists) {
    return tasksLists.where((task) => task.isDone).length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> tasksLists = state.allTasks;

        int completedTasks = _getCompletedTasks(tasksLists);
        int pendingTasks = tasksLists.length - completedTasks;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks App'),
            backgroundColor: Colors.blueAccent,
          ),
          body: tasksLists.isEmpty
              ? const Center(
                  child: Text(
                    'No Tasks found. Add a new Task',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                    
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text(
                            'Completed: $completedTasks, Pending: $pendingTasks',
                          ),
                        ),
                      ),
                    ),
                    TaskLists(tasksLists: tasksLists),
                    //TaskLists(tasksLists: tasksLists)
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
