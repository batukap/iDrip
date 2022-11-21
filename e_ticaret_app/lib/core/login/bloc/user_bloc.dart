import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_ticaret_app/core/login/model/login_model.dart';
import 'package:e_ticaret_app/core/login/repository/login_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final LoginService service;
  final box = GetStorage();

  bool isLoginFail = false;

  UserBloc(this.formKey, this.emailController, this.passwordController,
      {required this.service})
      : super(UserInitial()) {
    on<UserFetched>(_onUserFetched);
  }

  FutureOr<void> _onUserFetched(
      UserFetched event, Emitter<UserState> emit) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final data = (await service.loginCall(
              email: emailController.text, password: passwordController.text))!
          .message;

      box.write('token', data!.token.toString());

      if (data is LoginModelMessage) {
        emit(LoginComplete(data));
      }
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }
}
