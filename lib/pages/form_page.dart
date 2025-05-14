import 'package:flutter/material.dart';
import 'package:physiomobile_test/core/utils/constant.dart';
import 'package:provider/provider.dart';
import '../core/providers/form_provider.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _fullNameController = TextEditingController(
      text: formProvider.fullName ?? '',
    );
    final TextEditingController _emailController = TextEditingController(
      text: formProvider.email ?? '',
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text(
              'Please Enter Your Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Full Name Input
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                hintText: 'Enter your full name',
              ),
              validator: formProvider.validateFullName,
            ),
            const SizedBox(height: 20),

            // Email Input
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: formProvider.validateEmail,
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  formProvider.submitForm(
                    _fullNameController.text,
                    _emailController.text,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState?.reset();
                _fullNameController.clear();
                _emailController.clear();
                formProvider.resetForm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            // Display Result
            const SizedBox(height: 20),
            if (formProvider.fullName != null && formProvider.email != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Entered Data:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Full Name: ${formProvider.fullName}'),
                  Text('Email: ${formProvider.email}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
