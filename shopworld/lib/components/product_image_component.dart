import 'package:cached_network_image/cached_network_image.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String itemId;
  final String width;
  final String heigth;

  const ProductImage({
    super.key,
    this.itemId = '1',
    this.width = '150',
    this.heigth = '150',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Insets.l),
        ),
        child: CachedNetworkImage(
          height: double.parse(heigth),
          imageUrl: 'https://picsum.photos/$width/$heigth/?random=$itemId',
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              strokeWidth: Insets.xxs,
            ),
          ),
          errorWidget: (context, url, error) =>
              Image.asset('images/notfound.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
