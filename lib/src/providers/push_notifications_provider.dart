import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
//cMOvifi1TT2IHIs-eYwq0X:APA91bHwSv5tO6QdrNzq7_QLM5Y06HcXotEIa5pHy-kbRZ04ypNqcVG3H1d_wIC5iM6w_uXTMM2ofhf-680QMFmnhyaphFSUM7pe5u1VAifIbqNWrBdczqOmFcX8lHnurg9--TZ3XAnU

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajesStream => _mensajesStreamController.stream;

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  initNotification() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();
    print('==== FCM Token ====');
    print('token: $token');

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    //print('====== onMessage =======');
    //print('message: $message');
    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    //print('====== onLaunch =======');
    //print('message: $message');
    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    // print('====== onResume =======');
    // print('message: $message');
    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add(argumento);
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
