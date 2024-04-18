import 'package:hive/hive.dart';

part 'cached_feedback.g.dart';

@HiveType(typeId: CachedFeedback.typeId)
class CachedFeedback extends HiveObject {
  static const int typeId = 8;
  static const String boxName = "feedbacks";

  @HiveField(0)
  int id;

  @HiveField(1)
  int productId;

  @HiveField(2)
  int userId;

  @HiveField(3)
  String? content;

  @HiveField(4)
  int rating;

  @HiveField(5)
  bool updated;

  CachedFeedback({
    required this.id,
    required this.productId,
    required this.userId,
    this.content,
    this.rating = 0,
    this.updated = false,
  });
}
