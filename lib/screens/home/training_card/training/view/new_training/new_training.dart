import 'package:flutter/material.dart';

class TC_NewTraining extends StatefulWidget {
  const TC_NewTraining({super.key});

  @override
  State<TC_NewTraining> createState() => _NewTrainingState();
}

class _NewTrainingState extends State<TC_NewTraining> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Training')),
      body: const myForm(),
    );
  }
}

class myForm extends StatefulWidget {
  const myForm({super.key});

  @override
  State<myForm> createState() => _myFormState();
}

class _myFormState extends State<myForm> {
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Training Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter training name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Training Date'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter training date';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Process data
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
  
}