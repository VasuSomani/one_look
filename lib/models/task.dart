class Task {
  final String? taskID;
  final String title;
  final String body;
  final String deadlineDate;
  final String deadlineTime;
  final bool isCompleted;

  Task({
    required this.title,
    required this.body,
    required this.deadlineDate,
    required this.deadlineTime,
    this.isCompleted = false,
    this.taskID,
  });

  toJson() {
    return {
      'title': title,
      'body': body,
      'deadlineDate': deadlineDate,
      'deadlineTime': deadlineTime,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> data) {
    return Task(
      title: data['title'],
      body: data['body'],
      deadlineDate: data['deadlineDate'],
      deadlineTime: data['deadlineTime'],
      isCompleted: data['isCompleted'],
      taskID: data['taskID'],
    );
  }
}
