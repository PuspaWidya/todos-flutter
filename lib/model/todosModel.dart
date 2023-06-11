class TodosModel {
  final int id;
  final int userId;
  final String title;
  bool completed;

  TodosModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory TodosModel.fromJson(Map<String, dynamic> todo) {
    return TodosModel(
      id: todo['id'],
      userId: todo['userId'],
      title: todo['title'],
      completed: todo['completed'],
    );
  }
}
