import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:aniversaris/models/aniversari.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Madrid'));
    /* final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    ); */

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'BirthdayId', //Required for Android 8.0 or after
    'Birthdays', //Required for Android 8.0 or after
    'All birthday reminders are grouped in this channel', //Required for Android 8.0 or after
  );

  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  void sheduleNotification(Aniversari aniversari) async {
    final date = aniversari.dataNaixement;
    final id = aniversari.id;
    int year = DateTime.now().year;
    var bDayThisYear = DateTime(year, date.month, date.day);
    var nextBDay = bDayThisYear;
    if (bDayThisYear.isBefore(DateTime.now())) {
      nextBDay = DateTime(
        year + 1,
        date.month,
        date.day,
      );
    }
    var sheduledDate = tz.TZDateTime.local(
      nextBDay.year,
      nextBDay.month,
      nextBDay.day,
      9,
      0,
    );

    UILocalNotificationDateInterpretation uilLocalNotDI =
        UILocalNotificationDateInterpretation.absoluteTime;
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "Today is ${aniversari.nom} ${aniversari.cognom1} ${aniversari.cognom2} birthday",
        "Don't forget to congratulate ${aniversari.nom}",
        sheduledDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: uilLocalNotDI,
        payload: DateFormat('dd-MM-yyyy').format(sheduledDate));
    print('sheduledDate -------> ' + sheduledDate.toString());
  }

  /* void editsheduleNotification(Aniversari aniversari) async {
    flutterLocalNotificationsPlugin.
  } */

  void removeSheduleNotification(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }

  void listAllPendingNotifications() async {
    List<PendingNotificationRequest> listaNotif =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (int i = 0; i < listaNotif.length; i++) {
      print(
          '${listaNotif[i].title}  ${listaNotif[i].body}  ${listaNotif[i].payload}');
    }
  }
}
