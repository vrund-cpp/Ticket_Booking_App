import 'package:flutter/material.dart';

class OtpInput extends StatelessWidget {
  final List<TextEditingController> controllers;
  final void Function(String) onSubmit;

  const OtpInput({
    super.key,
    required this.controllers,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 50,
          child: TextField(
            controller: controllers[index],
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(counterText: ''),
            onChanged: (_) {
              final otp = controllers.map((c) => c.text).join();
              if (otp.length == 4) {
                onSubmit(otp);
              }
            },
          ),
        );
      }),
    );
  }
}
