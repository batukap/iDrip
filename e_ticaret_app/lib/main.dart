import 'package:e_ticaret_app/product/constants/constant.dart';
import 'package:e_ticaret_app/core/category/repo/category_service.dart';
import 'package:e_ticaret_app/view/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/category/bloc/category_bloc.dart';
import 'core/product/bloc/product_bloc.dart';
import 'core/product/repo/product_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(categoryService: CategoryService())
            ..add(const CategoryFetched()),
        ),
        BlocProvider(
            create: (context) => ProductBloc(productService: ProductService())
              ..add(const ProductFetched(id: "1"))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            backgroundColor: Constant.white,
            iconTheme: const IconThemeData(color: Colors.black)),
        home: LoginView(),
      ),
    );
  }
}
/*
{
    "email":"admin@ferisoft.com",
    "password":"test_password_123?"
}
*/