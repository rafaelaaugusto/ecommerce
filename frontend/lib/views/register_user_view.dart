import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../components/forms/user_form.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  FormGroup form = FormGroup({
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados pessoais'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Insets.l * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Por gentileza, informe seus dados pessoais para relizar a compra.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Insets.l),
              UserForm(form: form),
              const SizedBox(height: 70)
            ],
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
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Salvar dados'),
          ),
        ),
      ),
    );
  }
}
