

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcw/core/shared/shared_widget/custom_icon_dialog.dart';
import 'package:tcw/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:zapx/zapx.dart';

class PointsViewmodel {
  PointsViewmodel(this.context);
  late BuildContext context;

  Future<void> fetchStudentPushNotification()async {

    return await context.read<NotificationCubit>().fetchStudentPushNotification();
  }

}
