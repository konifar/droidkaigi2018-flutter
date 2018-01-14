abstract class Category {
  const Category(this.id, this.name);

  static const int DURATION_TYPE_ID = 808;
  static const int LANGUAGE_ID = 809;
  static const int TOPIC_ID = 811;
  static const int LEVEL_ID = 824;

  final int id;
  final String name;
}
