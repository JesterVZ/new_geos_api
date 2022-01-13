class Item{
  String text;
  bool canBeExpanded = false;
  bool isExpanded = false;
  int level;
  int type;
  List<Item> children;

  Item({this.text, this.level, this.type});
}