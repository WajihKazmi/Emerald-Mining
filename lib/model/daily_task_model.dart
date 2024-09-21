class DailyTask {
  final int id;
  final String title;
  final int coinReward;

  DailyTask  ({
    required this.id,
    required this.title,
    required this.coinReward,
  });

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    return DailyTask (
      id: json['id'],
      title: json['title'],
      coinReward: json['coin_reward'],
    );
  }

 
}
