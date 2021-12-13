import 'package:baseproject/models/product.dart';
import 'package:baseproject/screens/components/product_card.dart';
import 'package:flutter/cupertino.dart';

class ProductGrid extends StatelessWidget {
  final double childAspectRatio;
  final double maxCrossAxisExtent;
  final List<Product> products;

  const ProductGrid({
    Key? key,
    required this.childAspectRatio,
    required this.maxCrossAxisExtent,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: childAspectRatio,
        maxCrossAxisExtent: maxCrossAxisExtent,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: products.map((e) {
        return ProductCard(product: e);
      }).toList(),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
