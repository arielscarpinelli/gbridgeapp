import 'package:flutter/material.dart';
import 'package:gbridgeapp/service/gbridge_api.dart';
import 'package:gbridgeapp/widgets/device_list_screen.dart';
import 'package:provider/provider.dart';

import 'models/device_list_model.dart';
import 'models/login_model.dart';
import 'widgets/login_screen.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            builder: (context) => LoginModel(GBridgeApi())),
        ChangeNotifierProvider(
            builder: (context) => DeviceListModel(GBridgeApi(), context)),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gBridge',
      home: Consumer<LoginModel>(
          builder: (ctx, model, child) =>
              !model.loggedIn ? LoginScreen() : DeviceListScreen()),
    );
  }
}
