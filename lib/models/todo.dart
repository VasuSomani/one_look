class Todo {
  final String? todoID;
  final String title;
  final String body;
  final String category;
  final bool isCompleted;

  Todo({
    required this.title,
    required this.body,
    required this.category,
    this.isCompleted = false,
    this.todoID,
  });
  toJson() {
    return {
      'title': title,
      'body': body,
      'category': category,
      'isCompleted': isCompleted.toString(),
    };
  }

  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
      title: data['title'],
      body: data['body'],
      category: data['category'],
      todoID: data['todoID'],
    );
  }
}
