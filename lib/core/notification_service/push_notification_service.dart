import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

import 'notification_helper.dart';

typedef NotificationCallback = void Function(String? title, String? body);

class PushNotificationService implements NotificationHelper {
  static final http.Client _client = http.Client();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<void> initialize(NotificationCallback onMessageReceived) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen((message) {
        final title = message.notification?.title;
        final body = message.notification?.body;
        print('Message received: $title - $body');
        onMessageReceived(title, body);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('Message clicked!');
      });
      subscribeToAllUsersTopic();
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Future<String> getAccessToken() async {
    const serviceAccountJson = {
      "type": "service_account",
      "project_id": "my-new-shorts",
      "private_key_id": "89bc0e20538708d29094956689584187aed8f95e",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQClQIVMjEStPSjZ\nK7zCIZo5wxhqaNLPtEKfoNeQRTOu4SgY7FcalONd1egPiwkWzquoXE+Y0PPapZ08\nbb4qTwJiq+dFrqP1F6x0T/iBy62wsTjGaO910fuUAey54P46LMRvqYKv0Ha5rZVg\n47g3U9UABKyKcM0ZproRvgGs7Eh5ASiIlGMn1YgGjBC+76eDwacqLBkkFLQL/khq\niLIyMOxOUMQwVqOcXZqys6NR3MQHjDv81wlrcboZIWq+JT21rqCxJPNWOGb1oDng\ngv/jNt4S/3dr1Y/KXd08Pd8GKqw7MbDNb/pBaICwj6v2l5NIXVqjHm3xmafa3vvu\nZxzMPiuFAgMBAAECggEAJYZB7qiwZJ1NdAkWPwf11zV5yxn7+t2+PjS+FlzceFLY\n8dXjDp5uBc4PuM3T1cm+2YeCrJsQMJ9oVcM+yikwS7so1F4sjXhfePb64XBgg82u\nbIGCFMFGrSyFtozEde3Z+lgl3KoL96xWzg5Ps8KVzMAC9RnZvQAq4uIAS+XIrC8s\n2wCZZ6keiALaqQr6uPty4hEsNUCrLT19QBmmyj47J/wnAdJA1xTzx7rR/cYHSgTY\nYY4D5bKEaRuL5z1c+VRDKml6QSoCBDt1EqDeV5aPDkw2zmZ7kKbB8ywEqJj8wSwg\n/cjnwue4UT4WSNL058+/yAJKABkcXt0Lzh9Cveb5uQKBgQDnHJcfvkNWsqG3wVRS\njbDe0s10gHOshLHteFh2Htw/oMHdOUXAFESalwZi8TCxxJgjZWkVzOvQBhg9Px3V\n817fo+bbvllLfbCKLMRH8l0L876UQeJbuCThVhLGkOUNCMxxYMA3KGh5JCuAWjCV\n7lXfberwHlISNW+ydDyHh9Zl2QKBgQC3DEbQMhbI19z4S0tNZJHuVifuS9tE2PwW\n73APsgjIuy1W8Zu+KID9lbiMsIq/24XCENc1epJiV4k7NckgBbBVA52Lc9QGov+S\nWoNz78k48DJAMAEp5MtfpdCu641kbl5zNY4XlwQGcrbYEuv+ZGDG1mXuxwRMYu+6\nrrjzk23LjQKBgHq4Q8cnULqIwDbDAfOUKYcoiNCEJOhGzfQ7Iz4VxP5Ebqz57H/C\nQ2uTJmEDkcfTjLW+874PwmgD1HsxOLaTNJ2sernUqbXcWBIHE3Lgz2e5VkmDcp8h\nePPusKmf5wC021qY9XhUjKVG/5J4UbRLim3KACbg8tOYbGdmMX4GM2KBAn8XmH2I\nWOyW9zyExS/vygcFshVzolOhjFbynerUGx8GwRoXGw34dUArcCFaAWfhU2rqmUEk\no6g7BQ2rlENY3WLdkpm8YDH0qQ5Iz2Iij8ZgkJXpsEZ2IAgXTEiaQ8L2L0P9lem7\nILxkGGV5dPb20/mlp/17yivDrP06E0vEGj0NAoGBAMsK6zzXKs/3Hpcl8MYci81M\nF2gHRNzr4lFzrX8K7sVPIPdZ7FVmQkAEWH8rDsBah8f8/7u/3pjjcHwZyK+QiKNy\n7ZcZyAAYvGy79xgFd3hZXHtI2CbDY51YU9tUwdD+FpiiSXU7rTz2Im1TBvL53U6V\nXLzF42/qEHgxUCJ0RoaA\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-b80ws@my-new-shorts.iam.gserviceaccount.com",
      "client_id": "113149834077898689230",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-b80ws%40my-new-shorts.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    final scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/userinfo.email",
    ];

    try {
      final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        _client,
      );
      return credentials.accessToken.data;
    } catch (e) {
      print('Error obtaining access token: $e');
      throw Exception('Failed to obtain access token');
    }
  }

  @override
  Future<void> sendNotificationToSpecificUser({
    required String fcmToken,
    required String userId,
    required String title,
    required String body,
    required BuildContext context,
  }) async {
    try {
      final accessToken = await getAccessToken();
      final notificationPayload = {
        "message": {
          "token": fcmToken,
          "notification": {"title": title, "body": body},
          "data": {"user_id": userId},
        }
      };

      final response = await _client.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/my-new-shorts/messages:send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(notificationPayload),
      );

      if (response.statusCode == 200) {
        _showDialog(context, 'Success', 'Notification sent successfully.');
      } else {
        print('Error sending notification: ${response.body}');
        _showDialog(
            context, 'Error', 'Error sending notification: ${response.body}');
      }
    } catch (e) {
      _showDialog(context, 'Error', 'Error sending notification: $e');
    }
  }

  @override
  void subscribeToAllUsersTopic() {
    _firebaseMessaging.subscribeToTopic('allUsers');
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print(
        'Background message: ${message.notification?.title ?? ''} - ${message.notification?.body ?? ''}');
  }

  void _showDialog(BuildContext context, String title, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }
}
