
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_app/ui/registration_page.dart';

import '../business/authentication/authentication_bloc.dart';
import '../utils/authentication.dart';
import 'basket_page.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Вход'),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
  listener: (context, state) {
    if(state is Authenticated){
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BasketPage()),
                (route) => false);
      });
    }
    if (state is AuthError) {
      // Displaying the error message if the user is not authenticated
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.error)));
    }
  },
  builder: (context, state) {
    if (state is Loading) {
      // Displaying the loading indicator while the user is signing up
      return const Center(child: CircularProgressIndicator());
    }
    if (state is UnAuthenticated) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: 'Введите свой email',
                    hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
                    label: Text('Email',style: TextStyle(color: Color(0xff204531)),),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0
                        )
                    )
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    hintText: 'Введите свой пароль',
                    hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
                    label: Text('Пароль',style: TextStyle(color: Color(0xff204531)),),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0
                        )
                    )
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async{
                    final directory = await getApplicationDocumentsDirectory();
                    final file = File('${directory.path}/my_data.txt');
                    final text = '${_emailController.text} ${_passwordController.text}';
                    await file.writeAsString(text);
                    context.read<AuthenticationBloc>().add(SignInRequested(_emailController.text, _passwordController.text));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Войти'),
                  )
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Еще не зарегистрированы?',style: TextStyle(color: Colors.black)),
              TextButton(
                  onPressed: () {
                    Future.delayed(Duration.zero, () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => RegistrationPage()),
                              (route) => false);
                    });
                  },
                  child: const Text('Регистрация',style: TextStyle( color: Color(0xff204531)))
              )
            ],
          ),
        ),
      );
    }
    return Container();
  },
),
    );
  }
}
