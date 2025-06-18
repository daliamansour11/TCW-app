
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/constansts/context_extensions.dart';

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({
    super.key,
    required List<Map<String, dynamic>> transactions,
  }) : _transactions = transactions;

  final List<Map<String, dynamic>> _transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transaction History', style: GoogleFonts.lato(fontWeight: FontWeight.w600)),
         SizedBox(height: context.propHeight(16)),
        ..._transactions.map((transaction) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DATE & TIME\n${transaction["date"]}',
                      style: GoogleFonts.lato(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [  
                      Text('${transaction["amount"]}',
                          style: GoogleFonts.lato(
                              color: transaction['isIncome'] ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w600)),
                      Text('Credit Card', style: GoogleFonts.lato())
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('${transaction['details']}',
                      style: GoogleFonts.lato(fontSize: 12, color: Colors.black54)),
                  const Divider()
                ],
              ),
            ))
      ],
    );
  }
}