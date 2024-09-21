class EmeraldVideo {
  final int id;
  final String title;
  final int coinReward;
  final String url;

  EmeraldVideo ({
    required this.id,
    required this.title,
    required this.coinReward,
    required this.url,
  });

  factory EmeraldVideo.fromJson(Map<String, dynamic> json) {
    return EmeraldVideo (
      id: json['id'],
      title: json['title'],
      coinReward: json['coin_reward'],
      url: json['video_url'] ?? " ",
    );
  }

 
}
