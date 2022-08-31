import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../utils/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Authentication authentication;
  AuthenticationBloc({required this.authentication}) : super(UnAuthenticated()) {
    on<SignInRequested>((event, emit) async{
      emit(Loading());
      try{
        await authentication.loginUser(email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event,emit) async{
      emit(Loading());
      try{
        await authentication.registerUser(name: event.name, email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
  }
}
