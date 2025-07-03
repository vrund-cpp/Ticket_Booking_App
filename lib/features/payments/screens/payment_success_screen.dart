import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_booking_app/core/services/api_service.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final Map data;

  const PaymentSuccessScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final userId = data['userId'];
    final amount = data['amount'];
    final bookingId = data['bookingId'];
    final method = data['method'];

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            Text(
              'paymentSuccessful!'.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Amount Paid: ₹$amount'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Navigator.popUntil(context, (route) => route.isFirst);
                final success = await ApiService.createPayment(
                  userId,
                  bookingId,
                  amount,
                  method,
                );
                if (success) {
                  context.go('/dashboard');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('paymentEntryFailed'.tr())),
                  );
                }
              },
              child: Text('goToHome'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
