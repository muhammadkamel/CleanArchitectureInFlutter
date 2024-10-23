import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:oth_app/di_container.dart';
import 'package:oth_app/src/core/theme/app_theme.dart';
import 'package:oth_app/src/presentation/presentation.dart';

class OthApp extends StatelessWidget {
  const OthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(
            productUseCase: getIt(),
            productByIdUseCase: getIt(),
            saveProductsLocalUseCase: getIt(),
          )..add(
              GetProductsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => CartBloc(
            addCartProductUseCase: getIt(),
            getCartByIdUseCase: getIt(),
            removeCartProductUseCase: getIt(),
          )..add(
              GetCartByIdEvent("3"),
            ),
        ),
      ],
      child: RestorationScope(
        restorationId: 'oth_app',
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'oth_app',
          title: 'Oth',
          routerConfig: _routers,
          builder: (context, child) {
            return Theme(
              data: getLightTheme(context),
              child: child ?? const SizedBox(),
            );
          },
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
        ),
      ),
    );
  }
}

final GoRouter _routers = GoRouter(
  initialLocation: MainScreen.routePath,
  routes: <RouteBase>[
    GoRoute(
      path: MainScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => ManageBottomNavBloc()..add(UpdateIndexEvent(0)),
          child: const MainScreen(),
        );
      },
    ),
    GoRoute(
      path: '/product/:productId',
      name: "ProductDetailsScreen",
      builder: (BuildContext context, GoRouterState state) {
        final int productId = int.parse(state.pathParameters['productId']!);
        return BlocProvider(
          create: (context) => ProductBloc(
            productUseCase: getIt(),
            productByIdUseCase: getIt(),
            saveProductsLocalUseCase: getIt(),
          )..add(GetProductByIdEvent(productId: productId)),
          child: ProductDetailsScreen(productId: productId),
        );
      },
    ),
  ],
);
