import 'package:e_ticaret_app/core/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constant.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  String appbarTitle;

  CustomAppbar({Key? key, this.appbarTitle = "iDrip"})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        appbarTitle,
        style:
            const TextStyle(color: Constant.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart_rounded,
                    size: 35,
                    color: Colors.orange,
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 0,
                child: Container(
                  height: 17,
                  width: 17,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      return Center(
                          child: Text(
                        state.productNumber.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      backgroundColor: Constant.darkWhite,
    );
  }
  
}
