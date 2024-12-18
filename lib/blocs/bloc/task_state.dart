part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> removedTasks;
  final List<Task> allTasks;
  final String? errorMessage;

  const TaskState({
    this.allTasks = const <Task>[],
    this.removedTasks = const <Task>[],
    this.errorMessage,
  });

  @override
  List<Object> get props => [allTasks, removedTasks];

  Map<String, dynamic> toMap() {
    return {
      'allTasks': allTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList()
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
        allTasks: List<Task>.from(map['allTasks']?.map((x) => Task.fromMap(x))),
        removedTasks:
            List<Task>.from(map['removedTasks']?.map((x) => Task.fromMap(x))));
  }
}
