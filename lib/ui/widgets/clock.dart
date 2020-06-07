import 'package:flutter/material.dart';

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clock = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {
      return DateTime.now();
    });
    return StreamBuilder<DateTime>(
      stream: clock,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.toIso8601String());
        }
        return Text(DateTime.now().toIso8601String());
      },
    );
  }
}
