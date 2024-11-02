class SocialAccountTask {
  final int id;
  final String title;
  final int coinReward;
  final String url;

  SocialAccountTask ({
    required this.id,
    required this.title,
    required this.coinReward,
    required this.url,
  });

  factory SocialAccountTask.fromJson(Map<String, dynamic> json) {
    return SocialAccountTask (
      id: json['id'],
      title: json['platform'],
      coinReward: json['coin_reward'],
      url: json['url'] ?? " ",
    );
  }
}
