part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthenticationEvent{
  final String email;
  final String password;

  SignInRequested(this.email,this.password);
}

class SignUpRequested extends AuthenticationEvent{
  final String name;
  final String email;
  final String password;

  SignUpRequested(this.name,this.email,this.password);
}

class SignOutRequested extends AuthenticationEvent{}
