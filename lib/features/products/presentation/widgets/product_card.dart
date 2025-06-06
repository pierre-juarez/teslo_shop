import 'package:flutter/material.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImageViewer(images: product.images),
        Text(product.title, textAlign: TextAlign.center),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {
  const _ImageViewer({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/no_image.png', fit: BoxFit.cover, height: 250),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
        fit: BoxFit.cover,
        height: 250,
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 200),
        placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
        image: NetworkImage(images.first),
      ),
    );
  }
}
