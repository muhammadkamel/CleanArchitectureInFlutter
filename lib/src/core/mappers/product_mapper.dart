import 'package:oth_app/src/domain/entities/product_entity.dart';
import 'package:oth_app/src/domain/entities/rating_entity.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

extension ProductMapperX on ProductEntity {
  ProductModel toModel() {
    return ProductModel(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating.toModel(),
    );
  }
}

extension RatingEntityX on RatingEntity {
  RatingModel toModel() {
    return RatingModel(
      rate: rate,
      count: count,
    );
  }
}
