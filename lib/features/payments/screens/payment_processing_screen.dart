import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class PaymentProcessingScreen extends StatefulWidget {
  final Map data;

  const PaymentProcessingScreen({super.key, required this.data});

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final success = true;
      final double totalAmount = widget.data['amount'] ?? 0.0;
      final String bookingId = widget.data['bookingId'] ?? '';

      if (success) {
        context.go('/payment-success', extra: widget.data);
      }
      //  else {
      //     context.go('/payment-failed');
      //   }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
