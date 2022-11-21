import 'package:e_ticaret_app/core/category/bloc/category_bloc.dart';
import 'package:e_ticaret_app/view/pages/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    List items = [
      Colors.green.shade400,
      Colors.red.shade400,
      Colors.yellow.shade400,
      Colors.blue.shade400,
      Colors.orange.shade400,
      Colors.deepPurple.shade400,
      Colors.pink.shade400,
      Colors.teal.shade400,
      Colors.amber.shade400,
      Colors.indigo.shade400,
    ];
    return Scaffold(body: BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: state.category.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (() {
                        state.cId = state.category[index]!.id.toString();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductView(
                                      id: state.cId,
                                    )));
                      }),
                      title: Card(
                        color: items[index],
                        child: Center(
                          child: Text(
                            state.category[index]!.name.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        );
      },
    ));
  }
}
