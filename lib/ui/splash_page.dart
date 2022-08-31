import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_app/ui/basket_page.dart';
import 'package:shop_app/ui/login_page.dart';
import 'package:shop_app/utils/authentication.dart';

import '../business/authentication/authentication_bloc.dart';

class SplashPage extends StatelessWidget {
  checkSignedIn() async {
    List<String> data;
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.txt');
      String text = await file.readAsString();
      data = text.split(' ');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => BasketPage()),
                      (route) => false);
            });
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if(state is Loading){

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder<String>(
                        future:
                        FirebaseStorage.instance.ref('shop.png').getDownloadURL(),
                        builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState
                            ? Image.network(snapshot.data!)
                            : Icon(
                          Icons.shopping_basket,
                          color: Colors.white,
                          size: 70,
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: const Text(
                        'Cписок покупок',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              );
            }
            if(state is UnAuthenticated){
              // List data = checkSignedIn();
              // context.read<AuthenticationBloc>().add(SignInRequested(data[0], data[1]));
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
