import 'package:taskapp/model/task.dart';
import 'package:taskapp/objectbox.g.dart';

class Objectbox {

  late final Store store;
  late final Box<Task> taskBox;

  Objectbox._create(this.store){
    taskBox = store.box<Task>();
  }

  static Future<Objectbox> create() async{
    final store = await openStore();
    return Objectbox._create(store);
  }

}