import 'package:flutter/material.dart';
import 'package:new_shorts_app/core/notification_service/push_notification_service.dart';

abstract class NotificationHelper {
  const NotificationHelper._();
  Future<String> getAccessToken();
  Future<void> sendNotificationToSpecificUser({
    required String fcmToken,
    required String userId,
    required String title,
    required String body,
    required BuildContext context,
  });
  void subscribeToAllUsersTopic();

  Future<void> initialize(NotificationCallback onMessageReceived);
}
