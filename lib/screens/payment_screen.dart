import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatefulWidget {
final String userId;
final double amount;
final String bookingId;

const PaymentScreen({    super.key,
    required this.userId,
    required this.amount,
    required this.bookingId,});

@override
State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
final TextEditingController _cvvController = TextEditingController();
String _paymentMethod = 'card';
bool _cvvError = false;

void _proceedToPay() {
if (_paymentMethod == 'card' && _cvvController.text.length != 3) {
setState(() => _cvvError = true);
return;
}

context.push('/processing', extra: {
  'userId': widget.userId,
  'amount': widget.amount,
 'bookingId': widget.bookingId,
  'method': _paymentMethod,
});
}

@override
Widget build(BuildContext context) {
final total = widget.amount.toInt();
return Scaffold(
  backgroundColor: const Color(0xFFF0F2FA),
appBar: AppBar(
        backgroundColor: const Color(0xFF6A1B9A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title:  Text('Payment'.tr(), style: TextStyle(color: Colors.white)),
      ),
  body: SafeArea(
child: SingleChildScrollView(
  padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Purple Header: Payment Mode & Amount
      Container(
        color: const Color(0xFF6A1B9A),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text('paymentMode'.tr(), style: TextStyle(color: Colors.white, fontSize: 16)),
            Text('₹$total',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                        ),
          ],
        ),
      ),
      const SizedBox(height: 16),
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/visa.png', width: 32),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('4839-XXXX-XXXX-0127',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                            Text('Saved Card',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
      Radio<String>(
                        value: 'card',
                        groupValue: _paymentMethod,
                        onChanged: (value) =>
                            setState(() => _paymentMethod = value!),
                      )
                    ],
                  ),
                  if (_paymentMethod == 'card') ...[
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ENTER 3-DIGIT CVV CODE',
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            obscureText: true,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: const Color(0xFFF1F1F1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              counterText: '',
                              errorText: _cvvError ? 'Invalid CVV' : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.check_circle,
                            color: Colors.deepPurple, size: 24),
                      ],
                    ),
                  ],
                  const Divider(height: 24),
                  Row(
                    children: [
                      Image.asset('assets/icons/add_card.png',
                          width: 28, color: Colors.teal),
                      const SizedBox(width: 8),
                      const Text('New Card',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
const Spacer(),
                          const Text('Debit/Credit Card',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey)),                    
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text('Netbanking',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/icons/sbi.png', width: 36),
                Image.asset('assets/icons/hdfc.png', width: 36),
                Image.asset('assets/icons/axis.png', width: 36),
                Image.asset('assets/icons/icici.png', width: 36),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('More Banks >',
                style: TextStyle(
                    color: Colors.deepPurple.shade400,
                    fontWeight: FontWeight.w500,
                    fontSize: 13)),
          ),
            ],
          ),
        ),
      ),
          // Fixed Pay Button
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ElevatedButton(
          onPressed: _proceedToPay,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: const Color(0xFF6A1B9A),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text(
            'Pay Now',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}