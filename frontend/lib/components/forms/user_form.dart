import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UserForm extends StatelessWidget {
  final FormGroup form;

  const UserForm({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReactiveTextField(
            formControlName: 'name',
            decoration: const InputDecoration(
              labelText: 'Nome*',
            ),
            validationMessages: {
              ValidationMessage.required: (error) => 'Informe seu nome'
            },
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: Insets.xl),
          ReactiveTextField(
            formControlName: 'email',
            decoration: const InputDecoration(
              labelText: 'Email*',
            ),
            validationMessages: {
              ValidationMessage.required: (error) => 'Informe um email',
              ValidationMessage.email: (error) => 'Email inválido'
            },
          ),
          const SizedBox(height: Insets.xl),
          ReactiveTextField(
            formControlName: 'phone',
            decoration: const InputDecoration(
              labelText: 'Celular',
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: Insets.xl),
          const Text('Endereço de entrega'),
          const SizedBox(height: Insets.xl),
          ReactiveTextField(
            formControlName: 'adress.street',
            decoration: const InputDecoration(
              labelText: 'Rua*',
            ),
            validationMessages: {
              ValidationMessage.required: (error) => 'Informe a rua'
            },
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: Insets.xl),
          ReactiveTextField(
            formControlName: 'adress.city',
            decoration: const InputDecoration(
              labelText: 'Cidade*',
            ),
            validationMessages: {
              ValidationMessage.required: (error) => 'Informe a cidade'
            },
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: Insets.xl),
          Row(
            children: [
              Flexible(
                child: ReactiveTextField(
                  formControlName: 'adress.state',
                  decoration: const InputDecoration(
                    labelText: 'Estado*',
                  ),
                  validationMessages: {
                    ValidationMessage.required: (error) => 'Informe o estado'
                  },
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              const SizedBox(width: Insets.s),
              Flexible(
                child: ReactiveTextField(
                  formControlName: 'adress.zipcode',
                  decoration: const InputDecoration(
                    labelText: 'CEP*',
                  ),
                  validationMessages: {
                    ValidationMessage.required: (error) => 'Informe o CEP'
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.xl),
          ReactiveTextField(
            formControlName: 'adress.extra',
            decoration: const InputDecoration(
              labelText: 'Complemento',
            ),
            textCapitalization: TextCapitalization.words,
          ),
        ],
      ),
    );
  }
}
