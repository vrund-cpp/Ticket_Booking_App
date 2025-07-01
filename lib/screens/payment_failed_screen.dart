import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentFailedScreen extends StatelessWidget {
const PaymentFailedScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.red.shade50,
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(Icons.error, color: Colors.red, size: 80),
const SizedBox(height: 16),
 Text('paymentFailed'.tr(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
const SizedBox(height: 12),
 Text('somethingWentWrongPleaseTryAgain.'.tr()),
const SizedBox(height: 20),
ElevatedButton(
onPressed: () => Navigator.pop(context),
child:  Text('Retry'.tr()),
)
],
),
),
);
}
}