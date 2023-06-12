class TodosModel {
  final String id;
  final int userId;
  final String title;
  final bool completed;
  final String description;

  TodosModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.completed,
      required this.description});

  factory TodosModel.fromJson(Map<String, dynamic> todo) {
    return TodosModel(
      id: todo['id'],
      userId: todo['userId'],
      title: todo['title'],
      completed: todo['completed'],
      description: todo['description'],
    );
  }
}
