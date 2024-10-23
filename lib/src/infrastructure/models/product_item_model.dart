import 'package:equatable/equatable.dart';
import 'package:oth_app/src/domain/domain.dart';

class ProductItemModel extends Equatable {
  final int productId;
  final int quantity;

  const ProductItemModel({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        productId,
        quantity,
      ];

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      productId: productId,
      quantity: quantity,
    );
  }

  factory ProductItemModel.fromEntity(CartItemEntity entity) {
    return ProductItemModel(
      productId: entity.productId,
      quantity: entity.quantity,
    );
  }
}
