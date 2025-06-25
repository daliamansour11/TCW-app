import 'package:flutter/material.dart';
import 'package:tcw/core/shared/shared_widget/custom_text.dart';

class ActionItem {
  ActionItem({
    required this.title,
    this.icon,
    required this.onTap,
    this.iconColor,
    this.isDisabled = false,
    this.textColor,
  });

  final Color? textColor;
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback onTap;
  final bool isDisabled;
}

class CustomActionDropdown extends StatelessWidget {
  const CustomActionDropdown({super.key, required this.actions});
  final List<ActionItem> actions;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions
            .asMap()
            .entries
            .map(
              (entry) => Column(
                children: [
                  InkWell(
                    onTap: entry.value.isDisabled
                        ? null
                        : () async {
                            _popupEntry?.remove();
                            entry.value.onTap();
                          },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 12,
                        children: [
                          if (entry.value.icon != null)
                            Icon(
                              entry.value.icon,
                              color: entry.value.isDisabled
                                  ? Colors.grey
                                  : entry.value.iconColor ?? Colors.black,
                              size: 20,
                            ),
                          CustomText(
                            entry.value.title,
                            color: entry.value.isDisabled
                                ? Colors.grey
                                : entry.value.textColor ?? Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (entry.key != actions.length - 1)
                    const Divider(height: 1, thickness: 0.5),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

OverlayEntry? _popupEntry;
// Used only for long press to show the popup in GestureDetector widget
void showPopup({
  required BuildContext context,
  required Offset position,
  required List<ActionItem> actions,
}) {
   if (_popupEntry != null) {
    try {
      _popupEntry?.remove();
    } catch (_) {}
    _popupEntry = null;
  }


  _popupEntry = OverlayEntry(
    builder: (context) {
      return Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _popupEntry?.remove();
              _popupEntry = null;
            },
            child: Container(
              color: Colors.black.withValues(
                alpha: 0.3,
              ),
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy,
            child: CustomActionDropdown(actions: actions),
          ),
        ],
      );
    },
  );

  Overlay.of(context).insert(_popupEntry!);
  
}
