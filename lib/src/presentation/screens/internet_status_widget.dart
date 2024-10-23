import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:oth_app/src/core/core.dart';

class InternetStatusWidget extends StatefulWidget {
  const InternetStatusWidget({super.key});

  @override
  State<InternetStatusWidget> createState() => _InternetStatusWidgetState();
}

class _InternetStatusWidgetState extends State<InternetStatusWidget> {
  InternetStatus? _connectionStatus;
  late final StreamSubscription<InternetStatus> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: context.colorScheme.onSurface.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: switch (_connectionStatus) {
          null => _LoadingCircle(),
          InternetStatus.connected => const Text("Online"),
          InternetStatus.disconnected => const Text("Offline"),
        },
      ),
    );
  }
}

class _LoadingCircle extends StatelessWidget {
  const _LoadingCircle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
