import 'package:CheckIt/models/Category.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key,
      required this.categories,
      required this.categoryId,
      required this.handleCategoryClick});

  final List<Category> categories;
  final String categoryId;
  final Function(Category) handleCategoryClick;
  final imageUrl =
      'https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 200,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(
          categoryId,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: Row(
            children: categories.map(((category) {
              print(category.imageUrl);
              return InkWell(
                onTap: () => handleCategoryClick(category),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0)),
                        child: Image.network(
                          category.imageUrl,
                          width: 180,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(imageUrl,
                                width: 180,
                                height: 90,
                                fit: BoxFit.cover); //do something
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0)),
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category.categoryId,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ))
                    ]),
                  ),
                ),
              );
            })).toList(),
          ),
        )
      ]),
    );
  }
}
