import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business/authentication/authentication_bloc.dart';
import 'package:shop_app/business/shop_bloc.dart';

import 'package:shop_app/ui/splash_page.dart';
import 'package:shop_app/utils/authentication.dart';

import 'constants/theme_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAZgwCVa33mhWX2pSRhtHynqvHfWBChzC0",
            appId: "1:295247803438:web:9634d377f03856e3401bbf",
            messagingSenderId: "295247803438",
            projectId: "shop-app-blocone"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(authentication: Authentication()),
        ),
        BlocProvider(
          create: (context) => (ShopBloc()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: BasicTheme(),
        home: SplashPage(),
      ),
    );
  }
}
