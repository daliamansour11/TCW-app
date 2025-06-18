import 'package:flutter/material.dart';
import 'package:tcw/core/constansts/context_extensions.dart';
import 'package:tcw/core/shared/shared_widget/app_bar.dart';
import 'package:tcw/features/payment/presentation/widgets/balance_card_widget.dart';
import 'package:tcw/features/payment/presentation/widgets/payment_method_section.dart';
import 'package:tcw/features/payment/presentation/widgets/subscription_section.dart';
import 'package:tcw/features/payment/presentation/widgets/transaction_history_section.dart';

class PaymentsScreen extends StatelessWidget {
   PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: 'Payments',
                width: context.propWidth(40),
                
              ),
               SizedBox(height: context.propHeight(24)),
              BalanceCard(),
              const SizedBox(height: 24),
              PaymentMethodSection(),
              const SizedBox(height: 24),
              SubscriptionSection(),
              const SizedBox(height: 24),
              TransactionHistorySection(transactions: _transactions),
            ],
          ),
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
