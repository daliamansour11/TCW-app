

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcw/core/constansts/asset_manger.dart';
import 'package:tcw/core/constansts/context_extensions.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 1,
        color: const Color(0xFFE7E7E7),
      ),
      borderRadius: BorderRadius.circular(20),
    ),
  ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                AssetManger.balance,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text('Balance', style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
           SizedBox(height: context.propHeight(15)),
          Text(
            '\$1,502.45',
            style: GoogleFonts.lato(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color:  const Color(0xFF175941)
            ),
          ),
          SizedBox(height: context.propHeight(8)),
        ],
      ),
    );
  }
}