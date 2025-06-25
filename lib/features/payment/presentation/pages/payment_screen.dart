import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/payment/presentation/payment_viewmodel.dart';
import 'package:tcw/features/payment/presentation/widgets/payment_method_section.dart';
import 'package:tcw/features/payment/presentation/widgets/subscription_section.dart';
import 'package:tcw/features/payment/presentation/widgets/transaction_history_section.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
   late final PaymentViewmodel viewmodel;
   @override
  void initState() {
    super.initState();
    viewmodel=  PaymentViewmodel(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Payment',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            const PaymentMethodSection(),
            const SubscriptionSection(),
            TransactionHistorySection(transactions: _transactions),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _transactions = [
    {
      'date': '20 Jan, 01:00 Pm',
      'amount': '30\$',
      'isIncome': false,
      'details': 'Understanding Concept Of React Course'
    },
    {
      'date': '16 Jan, 01:00 Pm',
      'amount': '1000\$',
      'isIncome': true,
      'details': '-'
    },
    {
      'date': '14 Jan, 01:00 Pm',
      'amount': '60\$',
      'isIncome': false,
      'details': '-'
    },
  ];
}
