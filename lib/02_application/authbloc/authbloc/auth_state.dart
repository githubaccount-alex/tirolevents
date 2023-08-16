part of 'auth_bloc.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthStateAuthenticated extends AuthState {}

class AuthStateUnauthenticated extends AuthState {}
