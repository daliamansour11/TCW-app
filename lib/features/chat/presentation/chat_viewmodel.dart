import 'package:flutter/widgets.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';

class ChatViewmodel {
  ChatViewmodel(this.context);
  final BuildContext context;

  void onCreateGroup() {
    customIconDialog(
      context,
      title: 'Your Group Has Been Created',
    );
  }
}
