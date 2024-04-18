// external packages
import 'package:hive/hive.dart';

part 'cached_product_color.g.dart';

@HiveType(typeId: CachedProductColor.typeId)
class CachedProductColor extends HiveObject {
  static const int typeId = 4;
  static const String boxName = "productColors";

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  CachedProductColor({
    required this.id,
    required this.name,
    this.description,
  });
}
//
// static const Map<String, Color> _colorsMap = <String, Color>{
//   "black": Colors.black,
//   "white": Colors.white,
//   "red": Colors.red,
//   "pink": Colors.pink,
//   "purple": Colors.purple,
//   "deepPurple": Colors.deepPurple,
//   "indigo": Colors.indigo,
//   "blue": Colors.blue,
//   "lightBlue": Colors.lightBlue,
//   "cyan": Colors.cyan,
//   "teal": Colors.teal,
//   "green": Colors.green,
//   "lightGreen": Colors.lightGreen,
//   "lime": Colors.lime,
//   "yellow": Colors.yellow,
//   "amber": Colors.amber,
//   "orange": Colors.orange,
//   "deepOrange": Colors.deepOrange,
//   "brown": Colors.brown,
//   "grey": Colors.grey,
//   "blueGrey": Colors.blueGrey,
// };
//
// Color get asColor {
//   return _colorsMap[name.toLowerCase()]!;
// }
