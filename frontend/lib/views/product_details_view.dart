import 'package:brasil_fields/brasil_fields.dart';
import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

import '../components/product_image_component.dart';
import '../models/product_model.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        ModalRoute.of(context)?.settings.arguments as ProductModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sobre o Produto',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Insets.l * 2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(
                itemId: product.id,
                width: '400',
                heigth: '300',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.m),
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Row(
                children: [
                  Text(
                    UtilBrasilFields.obterReal(
                      double.parse(product.price),
                      moeda: true,
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: Insets.m),
                  if (product.hasDiscount && product.discountValue.isNotBlank)
                    Badge(
                      backgroundColor: Colors.red.shade200,
                      label: Text(
                        getPercentualValue(product.discountValue!),
                      ),
                    ),
                ],
              ),
              if (product.description.isNotBlank)
                buildSection(
                  context: context,
                  title: 'Descrição do produto',
                  text: product.description ?? '',
                ),
              if (product.department.isNotBlank)
                buildSection(
                  context: context,
                  title: 'Departamento',
                  text: product.department ?? '',
                ),
              if (product.material.isNotBlank)
                buildSection(
                  context: context,
                  title: 'Materiais',
                  text: product.material ?? '',
                ),
              if (product.details != null)
                buildSection(
                  context: context,
                  title: 'Detalhes',
                  text: product.details!.values.join(', '),
                ),
            ],
          ),
        ),
      ),
      bottomSheet: ElevatedButton(
        onPressed: () {},
        child: Text('Comprar'),
      ),
    );
  }
}

String getPercentualValue(String value) {
  String discount = (double.parse(value) * 100).toString();
  String discountFormatted = discount.endsWith('.0')
      ? discount.substring(0, discount.length - 2)
      : discount;

  return '$discountFormatted% off';
}

Widget buildSection({
  required BuildContext context,
  required String title,
  required String text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: Insets.l),
      Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    ],
  );
}
