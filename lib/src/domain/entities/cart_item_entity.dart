import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final int productId;
  final int quantity;
  final bool inCart;
  final double price;
  final String? name;
  final String? description;
  final String? imageUrl;

  const CartItemEntity({
    required this.productId,
    required this.quantity,
    this.inCart = false,
    this.price = 0.0,
    this.name,
    this.description,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        productId,
        quantity,
        inCart,
        price,
        name,
        description,
        imageUrl,
      ];

  CartItemEntity copyWith({
    int? productId,
    int? quantity,
    bool? inCart,
    double? price,
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      inCart: inCart ?? this.inCart,
      price: price ?? this.price,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  get isInCart => inCart;
}
