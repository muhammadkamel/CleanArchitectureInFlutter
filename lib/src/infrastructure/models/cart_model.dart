import 'package:equatable/equatable.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/infrastructure/models/product_item_model.dart';

class CartModel extends Equatable {
  final int id;
  final int userId;
  final String date;
  final List<ProductItemModel> products;

  const CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        date,
        products,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final products = json['products'] as List<dynamic>?;
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: products != null
          ? List<ProductItemModel>.from(
              products.map((product) => ProductItemModel.fromJson(product)),
            )
          : [],
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      id: id,
      userId: userId,
      date: date,
      products: products.map((product) => product.toEntity()).toList(),
      total: 222,
    );
  }

  CartModel.fromEntity(CartEntity entity)
      : id = entity.id,
        userId = entity.userId,
        date = entity.date,
        products = entity.products
            .map((product) => ProductItemModel.fromEntity(product))
            .toList();

  CartModel copyWith({
    int? id,
    int? userId,
    String? date,
    List<ProductItemModel>? products,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      products: products ?? this.products,
    );
  }
}
