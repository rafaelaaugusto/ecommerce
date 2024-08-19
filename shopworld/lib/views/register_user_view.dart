import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../components/forms/user_form.dart';
import '../components/layout_box_component.dart';
import '../models/user_model.dart';
import '../viewmodels/user_view_model.dart';

class RegisterUserView extends ConsumerStatefulWidget {
  const RegisterUserView({super.key});

  @override
  ConsumerState<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends ConsumerState<RegisterUserView> {
  bool isSaving = false;

  FormGroup form = FormGroup({
    'id': FormControl<String>(),
    'name': FormControl<String>(validators: [
      Validators.required,
    ]),
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
    'phone': FormControl<String>(),
    'adress': FormGroup({
      'street': FormControl<String>(validators: [
        Validators.required,
      ]),
      'city': FormControl<String>(validators: [
        Validators.required,
      ]),
      'zipcode': FormControl<String>(validators: [
        Validators.required,
      ]),
      'state': FormControl<String>(validators: [
        Validators.required,
      ]),
      'extra': FormControl<String>(),
    }),
  });

  @override
  Widget build(BuildContext context) {
    final userViewModel = ref.watch(userProvider);
    final bool isFromProfile =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados para entrega'),
      ),
      body: SingleChildScrollView(
        child: LayoutBox(
          child: Padding(
            padding: const EdgeInsets.all(Insets.l * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Por gentileza, informe seus dados para realizar a compra.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Insets.l),
                UserForm(form: form),
                const SizedBox(height: Insets.l * 7)
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.l * 2,
          vertical: Insets.l,
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              form.markAllAsTouched();

              if (form.valid) {
                setState(() {
                  isSaving = true;
                });

                final user = UserModel.fromJson(
                  userViewModel.getId,
                  form.value,
                );
                userViewModel.setUser(user);

                if (isFromProfile) {
                  Navigator.pop(context);
                } else {
                  Navigator.popAndPushNamed(
                    context,
                    '/checkout',
                  );
                }
              }
            },
            icon: isSaving
                ? SizedBox(
                    height: Insets.l,
                    width: Insets.l,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                      strokeWidth: Insets.xxs,
                    ),
                  )
                : const SizedBox(),
            label: const Text('Salvar dados'),
          ),
        ),
      ),
    );
  }
}
