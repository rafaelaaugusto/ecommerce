import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
    ]),
    'phone': FormControl<String>(validators: [
      Validators.required,
    ]),
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
        title: const Text('Entre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Insets.l * 2),
        child: Column(
          children: [
            const Text(
              'Por gentileza, informe seus dados pessoais para relizar a compra.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Insets.l),
            ReactiveForm(
              formGroup: form,
              child: Column(
                children: [
                  ReactiveTextField(
                    formControlName: 'name',
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
