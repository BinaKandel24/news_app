import 'package:news_app/model/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];

  category.add(
    new CategoryModel(
        categoryName: 'Business',
        imageUrl:
            'https://img.freepik.com/free-photo/business-people-shaking-hands-together_53876-20488.jpg?size=626&ext=jpg'),
  );

  category.add(
    new CategoryModel(
        categoryName: 'Entertainment',
        imageUrl:
            'https://www.oracle.com/a/ocom/img/cb71-media-entertainment-power-consumer-ebook.jpg'),
  );

  category.add(
    new CategoryModel(
        categoryName: 'General',
        imageUrl:
            'https://png.pngtree.com/element_pic/16/05/30/00574b163437ed1.jpg'),
  );

  category.add(
    new CategoryModel(
        categoryName: 'Health',
        imageUrl:
            'https://img.freepik.com/free-photo/business-people-shaking-hands-together_53876-20488.jpg?size=626&ext=jpg'),
  );

  category.add(
    new CategoryModel(
        categoryName: 'Science',
        imageUrl:
            'https://www.voorhees.k12.nj.us/cms/lib/NJ01000237/Centricity/Domain/4510/science%202.jpg'),
  );

  category.add(
    new CategoryModel(
        categoryName: 'Sports',
        imageUrl:
            'https://www.teahub.io/photos/full/5-56581_sports-wallpapers.jpg'),
  );

  category.add(
    new CategoryModel(
        categoryName: 'Technology',
        imageUrl:
            'https://www.investopedia.com/thmb/ooWnJKzULBikIcMgNqZdiRvHHBY=/2121x1414/filters:fill(auto,1)/GettyImages-964033964-ca3290057ccc4024b57e755423572264.jpg'),
  );

  return category;
}
