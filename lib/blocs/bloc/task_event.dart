part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class CreateTask extends TaskEvent {
  final Task task;

  const CreateTask({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}


class EditTask extends TaskEvent {
  final Task newTask;

  const EditTask({required this.newTask});

  @override
  List<Object> get props => [newTask];
}


class GetAllTasks extends TaskEvent {
  @override
  List<Object> get props => [];
}
