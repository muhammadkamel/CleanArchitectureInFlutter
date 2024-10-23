import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/application/application.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/presentation/presentation.dart';

class MockGetCartByIdUseCase extends Mock implements GetCartByIdUseCase {}

class MockAddCartProductUseCase extends Mock implements AddCartProductUseCase {}

class MockRemoveCartProductUseCase extends Mock
    implements RemoveCartProductUseCase {}

void main() {
  late CartBloc cartBloc;
  late MockGetCartByIdUseCase mockGetCartByIdUseCase;
  late MockAddCartProductUseCase mockAddCartProductUseCase;
  late MockRemoveCartProductUseCase mockRemoveCartProductUseCase;

  setUp(() {
    mockGetCartByIdUseCase = MockGetCartByIdUseCase();
    mockAddCartProductUseCase = MockAddCartProductUseCase();
    mockRemoveCartProductUseCase = MockRemoveCartProductUseCase();

    cartBloc = CartBloc(
      getCartByIdUseCase: mockGetCartByIdUseCase,
      addCartProductUseCase: mockAddCartProductUseCase,
      removeCartProductUseCase: mockRemoveCartProductUseCase,
    );

    registerFallbackValue(CartItemEntity(productId: 2, quantity: 1));
  });

  tearDown(() {
    cartBloc.close();
  });

  group('CartBloc', () {
    test('initial state is CartStatus.initial', () {
      expect(cartBloc.state.status, CartStatus.initial);
    });

    blocTest<CartBloc, CartState>(
      'emits [loading, success] when AddToCartEvent is added',
      build: () {
        when(() => mockAddCartProductUseCase.call(any()))
            .thenAnswer((_) async => Right(CartEntity(
                  id: 3,
                  userId: 323,
                  date: '2022-01-01',
                  products: [],
                  total: 10.0,
                ))); // Mock successful addition
        return cartBloc;
      },
      act: (bloc) => bloc.add(
        AddToCartEvent(
          CartItemEntity(productId: 1, price: 10.0, quantity: 1),
        ),
      ),
      expect: () => [
        CartState(status: CartStatus.loading),
        CartState(
          status: CartStatus.success,
          cart: CartEntity(
            id: 3,
            userId: 323,
            date: '2022-01-01',
            products: [],
            total: 10.0,
          ),
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [loading, success] when GetCartByIdEvent is added',
      build: () {
        when(() => mockGetCartByIdUseCase.call(any()))
            .thenAnswer((_) async => Right(CartEntity(
                  id: 3,
                  userId: 323,
                  date: '2022-01-01',
                  products: [],
                  total: 10.0,
                ))); // Mock successful retrieval
        return cartBloc;
      },
      act: (bloc) => bloc.add(GetCartByIdEvent('1')),
      expect: () => [
        CartState(status: CartStatus.loading),
        CartState(
          status: CartStatus.success,
          cart: CartEntity(
            id: 3,
            userId: 323,
            date: '2022-01-01',
            products: [],
            total: 10.0,
          ),
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [loading, success] when RemoveFromCartEvent is added',
      build: () {
        when(() => mockRemoveCartProductUseCase.call(any()))
            .thenAnswer((_) async => Right(CartEntity(
                  id: 3,
                  userId: 323,
                  date: '2022-01-01',
                  products: [],
                  total: 10.0,
                )));
        return cartBloc;
      },
      act: (bloc) => bloc.add(
        RemoveFromCartEvent(
          CartItemEntity(
            productId: 1,
            price: 10.0,
            quantity: 1,
          ),
        ),
      ),
      expect: () => [
        CartState(status: CartStatus.loading),
        CartState(
          status: CartStatus.success,
          cart: CartEntity(
            id: 3,
            userId: 323,
            date: '2022-01-01',
            products: [],
            total: 10.0,
          ),
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [loading, success] with null cart when AddToCartEvent fails',
      build: () {
        when(() => mockAddCartProductUseCase.call(any())).thenAnswer(
          (_) async => Left(
            ServerFailure("Failed to add product to cart"),
          ),
        );
        return cartBloc;
      },
      act: (bloc) => bloc.add(
        AddToCartEvent(
          CartItemEntity(
            productId: 1,
            price: 10.0,
            quantity: 1,
          ),
        ),
      ),
      expect: () => [
        CartState(status: CartStatus.loading),
        CartState(
          status: CartStatus.success,
          cart: null,
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [loading, success] with null cart when GetCartByIdEvent fails',
      build: () {
        when(() => mockGetCartByIdUseCase.call(any()))
            .thenAnswer((_) async => Left(ServerFailure('Failed to get cart')));
        return cartBloc;
      },
      act: (bloc) => bloc.add(GetCartByIdEvent('1')),
      expect: () => [
        CartState(status: CartStatus.loading),
        CartState(
          status: CartStatus.success,
          cart: null,
        ),
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [loading, success] with null cart when RemoveFromCartEvent fails',
      build: () {
        when(() => mockRemoveCartProductUseCase.call(any()))
            .thenAnswer((_) async => Left(ServerFailure("Failed to remove")));
        return cartBloc;
      },
      act: (bloc) => bloc.add(
        RemoveFromCartEvent(
          CartItemEntity(
            productId: 1,
            price: 10.0,
            quantity: 1,
          ),
        ),
      ),
      expect: () => [
        CartState(status: CartStatus.loading),
        CartState(
          status: CartStatus.success,
          cart: null,
        ),
      ],
    );
  });
}
