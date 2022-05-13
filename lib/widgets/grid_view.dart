import 'package:books/widgets/productItem.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/productprovider.dart';

class ProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProviders>(context);
    final List<Book> loadedProduct = productData.items;
    return GridView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(2.0),
      itemCount: loadedProduct.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProduct[i],
        child: ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // mainAxisExtent: 0.2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 4),
    );
  }
}
