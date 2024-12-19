import 'package:objectbox/objectbox.dart';

// ignore: must_be_immutable
@Entity()
class Task {
  @Id(assignable: true)
  late int id = 0;
  late String title;
  late String description;
  bool isDone = false;
  bool isDeleted = false;
  late String date;
  bool isSynced = false;

  Task({
    this.id = 0,
    required this.date,
    required this.title,
    required this.description,
    this.isDone = false,
    this.isDeleted = false,
  });

  Task copyWith({
    String? title,
    String? description,
    int? id,
    String? date,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'description': description,
      'title': title,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isSynced': isSynced,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? 0,
      date: map['date'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  List<Object?> get props => [id, date, title, description, isDone, isDeleted];
}
