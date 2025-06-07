import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';
import 'package:teslo_shop/features/products/presentation/providers/product_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar producto'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined))],
      ),
      body: productState.isLoading ? const FullScreenLoader() : _ProductView(product: productState.product!),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.save_as_outlined)),
    );
  }
}

class _ProductView extends StatelessWidget {
  const _ProductView({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        SizedBox(height: 250, width: 600, child: _ImageGallery(images: product.images)),

        const SizedBox(height: 10),
        Center(child: Text(product.title, style: textStyles.titleSmall)),
        const SizedBox(height: 10),
        _ProductInformation(product: product),
      ],
    );
  }
}

class _ProductInformation extends ConsumerWidget {
  const _ProductInformation({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15),
          CustomProductField(isTopField: true, label: 'Nombre', initialValue: product.title),
          CustomProductField(label: 'Slug', initialValue: product.slug),
          CustomProductField(
            isBottomField: true,
            label: 'Precio',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: product.price.toString(),
          ),

          const SizedBox(height: 15),
          const Text('Extras'),

          _SizeSelector(selectedSizes: product.sizes),
          const SizedBox(height: 5),
          _GenderSelector(selectedGender: product.gender),

          const SizedBox(height: 15),
          CustomProductField(
            isTopField: true,
            label: 'Existencias',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: product.stock.toString(),
          ),

          CustomProductField(
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: product.description,
          ),

          CustomProductField(
            isBottomField: true,
            maxLines: 2,
            label: 'Tags (Separados por coma)',
            keyboardType: TextInputType.multiline,
            initialValue: product.tags.join(', '),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _SizeSelector extends StatelessWidget {
  const _SizeSelector({required this.selectedSizes});
  final List<String> selectedSizes;
  final List<String> sizes = const ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      emptySelectionAllowed: true,
      showSelectedIcon: false,
      segments:
          sizes.map((size) {
            return ButtonSegment(value: size, label: Text(size, style: const TextStyle(fontSize: 10)));
          }).toList(),
      selected: Set.from(selectedSizes),
      onSelectionChanged: print,
      multiSelectionEnabled: true,
    );
  }
}

class _GenderSelector extends StatelessWidget {
  const _GenderSelector({required this.selectedGender});
  final String selectedGender;
  final List<String> genders = const ['men', 'women', 'kid'];
  final List<IconData> genderIcons = const [Icons.man, Icons.woman, Icons.boy];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments:
            genders.map((size) {
              return ButtonSegment(
                icon: Icon(genderIcons[genders.indexOf(size)]),
                value: size,
                label: Text(size, style: const TextStyle(fontSize: 12)),
              );
            }).toList(),
        selected: {selectedGender},
        onSelectionChanged: print,
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  const _ImageGallery({required this.images});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children:
          images.isEmpty
              ? [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover),
                ),
              ]
              : images.map((e) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.network(e, fit: BoxFit.cover),
                );
              }).toList(),
    );
  }
}
