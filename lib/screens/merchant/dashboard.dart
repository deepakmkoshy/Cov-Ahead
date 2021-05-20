import 'package:covid_qrcode_bfh/models/merchant.dart';
import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/screens/merchant_or_customer.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:covid_qrcode_bfh/services/merchant_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MerchantDashboard extends StatefulWidget {
  @override
  _MerchantDashboardState createState() => _MerchantDashboardState();
}

class _MerchantDashboardState extends State<MerchantDashboard> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Merchant Dashboard'),
        actions: [
          IconButton(
              icon: Icon(Icons.power_settings_new_rounded),
              onPressed: () {
                _auth.signOut();

                Get.offAll(() => MerchantOrCustomer());
              })
        ],
      ),
      body: Consumer<UserModel>(builder: (context, merchant, child) {
        // Following condition to prevent accessing uid after logging out
        // Merchant becomes null after logging out, so this is required
        if (merchant == null)
          return Container();
        else
          return StreamBuilder<List<MerchantVisitorLog>>(
            stream: MerchDatabaseService(uid: merchant.uid).visitorsLog,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print('Inside builder: ' + snapshot.data.toString());
                return Center(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].customerName),
                        leading:
                            Text(snapshot.data[index].timestamp.toString()),
                      );
                    },
                  ),
                );
              }
              print('NO data');
              return CircularProgressIndicator();
            },
          );
      }),
    );
  }
}
