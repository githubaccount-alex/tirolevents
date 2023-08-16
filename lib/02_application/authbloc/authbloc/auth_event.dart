part of 'auth_bloc.dart';


abstract class AuthEvent {}

class SignOutPressedEvent extends AuthEvent {}

class AuthCheckRequestedEvent extends AuthEvent {}
