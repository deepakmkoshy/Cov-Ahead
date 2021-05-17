import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:flutter/material.dart';

class EditDetailsCustomer extends StatefulWidget {
  EditDetailsCustomer({Key key}) : super(key: key);

  @override
  _EditDetailsCustomerState createState() => _EditDetailsCustomerState();
}

class _EditDetailsCustomerState extends State<EditDetailsCustomer> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

  String name = '';
  String email = '';
  String phoneNum = '';
  String address = '';
  int value = 1; //For dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Sign In"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) =>
                          value.isEmpty ? 'Field Cannot be Blank ' : null,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Mail ID'),
                      validator: (value) =>
                          value.isEmpty ? 'Field Cannot be Blank ' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter your Number ' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    TextFormField(
                      minLines: 3,
                      maxLines: 3,
                      decoration: InputDecoration(labelText: 'Address'),
                    ),
                    // Vaccine status dropdown, needs improvement
                    DropdownButton(
                        value: value,
                        onChanged: (val) {
                          setState(() {
                            value = val;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                              child: Text('Not vaccinated'), value: 1),
                          DropdownMenuItem(
                              child: Text('Taken First Dose'), value: 2),
                          DropdownMenuItem(
                              child: Text('Fully vaccinated'), value: 3),
                        ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
