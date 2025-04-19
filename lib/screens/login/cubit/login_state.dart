part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


class LoadingLoginState extends LoginState{}
class SuccessLoginState extends LoginState{}
class ErrorLoginState extends LoginState{}