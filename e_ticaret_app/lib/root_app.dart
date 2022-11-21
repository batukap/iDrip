import 'package:e_ticaret_app/product/components/custom_appbar.dart';
import 'package:e_ticaret_app/view/pages/cart_view.dart';
import 'package:e_ticaret_app/view/pages/category_view.dart';
import 'package:e_ticaret_app/view/pages/home_view.dart';
import 'package:e_ticaret_app/view/pages/wishlist_view.dart';
import 'package:flutter/material.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  RootAppState createState() => RootAppState();
}

class RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [HomeView(), WishListView(), CategoryView(), CartView()],
    );
  }

  Widget getFooter() {
    List items = [
      Icons.home_rounded,
      Icons.bookmark_rounded,
      Icons.widgets_rounded,
      Icons.shopping_basket_rounded,
    ];
    List texts = ["Home", "WishList", "Category", "Cart"];
    return Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(width: 1, color: Colors.black.withOpacity(0.06))),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  pageIndex = index;
                });
              },
              child: Column(
                children: [
                  Icon(
                    items[index],
                    size: 25,
                    color: pageIndex == index ? Colors.orange : Colors.black,
                  ),
                  Text(
                    texts[index],
                    style: TextStyle(
                        color:
                            pageIndex == index ? Colors.orange : Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
