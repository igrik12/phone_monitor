import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key key}) : super(key: key);

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your name',
                  labelText: 'Name *',
                ),
                style: Get.textTheme.copyWith().headline6,
                autocorrect: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your email',
                  labelText: 'Email *',
                ),
                style: Get.textTheme.copyWith().headline6,
                autocorrect: true,
                validator: (value) {
                  if (value.isEmpty || !GetUtils.isEmail(value)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Enter your suggestions/issues here",
                ),
              )
            ],
          )),
    );
  }
}
