class Category {
  String categoryId;
  String parentId;
  String imageUrl;

  Category({
    required this.categoryId,
    required this.parentId,
    required this.imageUrl,
  });

  Category.fromSnapshot(Map<String, dynamic> snapshot)
      : categoryId = snapshot['id'].toString(),
        imageUrl = snapshot['ImageUrl'].toString(),
        parentId = snapshot['mainId'].toString();
}
