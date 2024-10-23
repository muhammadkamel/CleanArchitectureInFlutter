import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class InternetChecker {
  Future<bool> get isConnected;
}

class InternetCheckerImpl implements InternetChecker {
  final InternetConnection internetConnection;

  const InternetCheckerImpl({required this.internetConnection});

  @override
  Future<bool> get isConnected async {
    return await internetConnection.hasInternetAccess;
  }
}
