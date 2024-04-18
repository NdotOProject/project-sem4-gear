import 'package:hive/hive.dart';

part 'cached_order_status.g.dart';

@HiveType(typeId: CachedOrderStatus.typeId)
class CachedOrderStatus {
  static const int typeId = 100;
}
