import 'package:equatable/equatable.dart';
import 'package:taskapp/blocs/bloc_exports.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/models/task.dart';
import 'package:taskapp/repository/firestore_repository.dart';
import 'package:taskapp/services/network_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<EditTask>(_onEditTask);
    on<CreateTask>(_onCreateTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<GetAllTasks>(_onGetAllTasks);
    //on<RestoreTask>(_onRestoreTask);
    //on<RemoveTask>(_onRemoveTask);
  }

  //Here we are creating the task.
  Future<void> _onCreateTask(CreateTask event, Emitter<TaskState> emit) async {
    //Creating the task locally first
    objectbox.taskBox.put(event.task);
    //creating task on firebase
    try {
      await FirestoreRepository.createTask(event.task);
    } on Exception catch (e) {
      emit(TaskState(errorMessage: "Failed to create task : ${e.toString()}"));
    }
  }

  //Retreiving all the tasks form the database.
  Future<void> _onGetAllTasks(
      GetAllTasks event, Emitter<TaskState> emit) async {
    List<Task> allTasks = [];

    final localTasks =
        objectbox.taskBox.getAll().where((task) => !task.isDeleted).toList();

    // Fetching task from firestore and putting in localstorage
    bool isConnected = await NetworkService.available();
    if (isConnected) {
      try {
        final firebaseTasks = await FirestoreRepository.getTasks();
        for (var task in firebaseTasks) {
          objectbox.taskBox.put(task);
        }
        // Now refresing the local data
        final updatedTasks = objectbox.taskBox
            .getAll()
            .where((task) => !task.isDeleted)
            .toList();
        allTasks.addAll(updatedTasks);
      } catch (e) {
        emit(TaskState(errorMessage: "Failed to get tasks : ${e.toString()}"));
        return;
      }
    } else {
      //if there is no internet connection then we will show the local tasks
      allTasks.addAll(localTasks);
    }
    emit(TaskState(allTasks: allTasks));
  }

  //Updating the task whether it is completed or not
  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    Task updateTask = event.task.copyWith(isDone: !event.task.isDone);

    //updating the task locally first
    objectbox.taskBox.put(updateTask);

    //then trying to sync with database
    try {
      await FirestoreRepository.updateTask(updateTask);
      objectbox.taskBox.put(updateTask);
    } catch (e) {
      emit(TaskState(errorMessage: "Failed to update task : ${e.toString()}"));
    }
  }

  //Editing the task
  void _onEditTask(EditTask event, Emitter<TaskState> emit) async {
    // Editing the task locally first
    objectbox.taskBox.put(event.newTask);

    // Trying to edit on server
    try {
      await FirestoreRepository.updateTask(event.newTask);
    } on Exception catch (e) {
      emit(TaskState(errorMessage: "Failed to edit: ${e.toString()}"));
    }
  }

  //Deleting the task from database.
  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    //deleting the task from local storage
    objectbox.taskBox.remove(event.task.id);

    //deleting the task from database
    try {
      await FirestoreRepository.deleteTask(event.task);
    } on Exception catch (e) {
      emit(TaskState(errorMessage: "Failed to delete task : ${e.toString()}"));
    }
  }
}  


  //Restoring the task from the recycle bin
  // void _onRestoreTask(RestoreTask event, Emitter<TaskState> emit) async {
  //   Task restoreTask = event.task.copyWith(isDeleted: false);

  //   //Updating the task locally first 
  //   objectbox.taskBox.put(restoreTask);

  //   //then trying to sync with database
  //   try {
  //     await FirestoreRepository.updateTask(restoreTask);
  //   } on Exception catch (e) {
  //     emit(TaskState(errorMessage: "Failed to restore task : ${e.toString()}"));
  //   }
  //   //_emitUpdatedTask(emit);
  // }

  //Deleting the task temporarily
  // void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) async {
  //   //deleting the task from database
  //   try {
  //     await FirestoreRepository.deleteTask(event.task);
  //   } catch(e){
  //     emit(TaskState(errorMessage: "Failed to remove task : ${e.toString()}"));
  //   }
  //   //_emitUpdatedTask(emit);
  // }
