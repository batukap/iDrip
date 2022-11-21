part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class LoginValidateState extends UserState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}
class LoginComplete extends UserState {
  final LoginModelMessage model;

  LoginComplete(this.model);

}

