//
// import 'package:amplify_api/amplify_api.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:amplify_api/amplify_api.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:bloc/bloc.dart';
import 'package:box_of_items/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'amplifyconfiguration.dart';
import 'bloc_box/box_bloc.dart';
import 'bloc_box/box_event.dart';
import 'bloc_observer.dart';
import 'box_view.dart';
import 'models/ModelProvider.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.teal,
        ),
        home: _isAmplifyConfigured
            ? BlocProvider<BoxBloc>(
                create: (context) => BoxBloc()
                  ..add(BoxLoadEvent())..add(BoxObserve()),
                  // ..boxItemsRepository.observeItems(),
                child: BoxView(),
              )
            : LoadingView());
  }

  // home: BlocProvider(
  //     create: (context) =>
  //        BoxBloc()..boxItemsRepository.getItems()..boxItemsRepository.observeItems(),

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        // AmplifyAuthCognito(),
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAPI(),
        // AmplifyStorageS3(),
        // AmplifyAnalyticsPinpoint(),
      ]);

      await Amplify.configure(amplifyconfig);

      setState(() => _isAmplifyConfigured = true);
    } catch (e) {
      print(e);
    }
  }
}
