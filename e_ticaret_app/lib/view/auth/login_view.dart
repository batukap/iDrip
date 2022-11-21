import 'package:e_ticaret_app/core/login/repository/login_service.dart';
import 'package:e_ticaret_app/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/login/bloc/user_bloc.dart';
import '../../core/login/components/login_buton.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
          formKey, emailController, passwordController,
          service: LoginService()),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is LoginComplete) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const RootApp()));
          }
          if (state is LoginValidateState) {
            const snackBar = SnackBar(content: Text("Hatalı Giriş"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, UserState state) {
    var autovalidateMode = state is LoginValidateState
        ? (state.isValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled)
        : AutovalidateMode.disabled;
    return Scaffold(
      body: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _WelcomeText(),
                EmailField(emailController: emailController),
                const SizedBox(
                  height: 30,
                ),
                PasswordField(passwordController: passwordController),
                GestureDetector(
                  onTap: () {
                    context.read<UserBloc>().add(UserFetched());
                  },
                  child: const LoginButton(),
                ),
              ],
            ),
          )),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 100),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.lock_outline,
                color: Colors.black.withOpacity(0.5),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  cursorColor: Colors.black.withOpacity(0.5),
                  decoration: const InputDecoration(
                      hintText: "Şifre", border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Icon(
                Icons.email_outlined,
                color: Colors.black.withOpacity(0.5),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: TextField(
                  controller: emailController,
                  cursorColor: Colors.black.withOpacity(0.5),
                  decoration: const InputDecoration(
                      hintText: "Email", border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 50.0, bottom: 10),
          child: Text(
            "Merhaba,",
            style: TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 70.0),
          child: Text(
            "Tekrar Hoşgeldin",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
