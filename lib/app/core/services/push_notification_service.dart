import 'package:firebase_messaging/firebase_messaging.dart';

abstract class PushNotificationService {
  void init();

  Future<void> disableNotifications();
}

class PushNotificationServiceFirebaseImp implements PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  bool _initialized = false;
  get initialized => _initialized;
  setInitialized(bool value) => _initialized = value;

  @override
  void init() async {
    if (!_initialized) {
      var token = await _fcm.getToken();
      print("Your Token: $token");
      FirebaseMessaging.onMessage.listen(_handleMessage);
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    }
  }

  @override
  Future<void> disableNotifications() async {
    print('Desativando notificações do usuário');

    _initialized = false;
    _fcm.deleteToken();
    // Se tivesse talvo em algum lugar desativar por aqui.
    // final String tokenId = await locator<StorageService>().notificationsTokenId;
    // final ret = await locator<Api>().deleteDataFrom('user-fcm-tokens', tokenId);
    // return ret;
  }

  void _handleMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
