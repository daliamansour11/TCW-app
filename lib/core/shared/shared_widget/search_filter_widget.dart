import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({super.key,  this.onChanged});
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              spacing: 12,
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: 'Search your course here....',
                      hintStyle: GoogleFonts.poppins(fontSize: 12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Icon(Icons.filter_alt_outlined, size: 30),
      ],
    );
  }
}
