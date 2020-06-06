import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlix_farmer/core/providers/farmerProvider.dart';
import 'package:urlix_farmer/core/providers/loggerProvider.dart';
import 'package:urlix_farmer/locator.dart';
import 'package:urlix_farmer/ui/views/config.dart';
import 'package:urlix_farmer/ui/views/logger.dart';
import 'package:urlix_farmer/ui/views/home.dart';

void main() {
  setupLocator();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => locator<FarmerProvider>()..setupFarmers(),
      ),
      ChangeNotifierProvider(
        create: (_) => locator<LoggerProvider>(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UrLix Farmer',
      theme: ThemeData.dark().copyWith(
        //textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Inconsolata'),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Main(),
        '/config': (context) => Config(),
        '/logs': (context) => Logger(),
      },
    ),
  ));
}

class Main extends StatelessWidget {
  const Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Logger(),
        MainView(),
      ],
    );
  }
}
