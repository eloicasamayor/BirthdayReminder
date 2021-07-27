import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:aniversaris/models/aniversari.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    initializeDateFormatting('en', null);
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

  /* DateTime sheduleNotification(Aniversari aniversari) {
    final date = aniversari.dataNaixement;
    final id = aniversari.id;
    late var sheduledDate;
    late var nextBDay;
    int year = DateTime.now().year; */
  Future<String> getTimeNotificationString() async {
    String _timeNotification = '09:00';
    await SharedPreferences.getInstance().then((value) {
      if (value.containsKey("notification_hour")) {
        _timeNotification = value.getString("notification_hour") ?? '09:00';
      } else {
        _timeNotification = '09:00';
      }
      print('_timeNotification = $_timeNotification');
      //return timeNotification;
    });
    print('i aqui fora ==> _timeNotification = $_timeNotification');
    return _timeNotification;
  }

  Future<tz.TZDateTime> setNextNotificationDateTime(
    Aniversari aniversari,
    String _timeInDay,
  ) async {
    print('_timeInDay=$_timeInDay');
    final date = aniversari.dataNaixement;
    var _nextBDay = DateTime(
      DateTime.now().year,
      date.month,
      date.day,
      int.parse(_timeInDay.substring(0, 2)),
      int.parse(_timeInDay.substring(3, 5)),
    );

    if (_nextBDay.isBefore(DateTime.now())) {
      _nextBDay = DateTime(
        DateTime.now().year + 1,
        date.month,
        date.day,
        int.parse(_timeInDay.substring(0, 2)),
        int.parse(_timeInDay.substring(3, 5)),
      );
    }
    print('_nextBDay= ${_nextBDay.toString()}');
    tz.TZDateTime _scheduledDateTime = tz.TZDateTime.local(
      _nextBDay.year,
      _nextBDay.month,
      _nextBDay.day,
      _nextBDay.hour,
      _nextBDay.minute,
    );
    print('_scheduledDateTime= ${_scheduledDateTime.toString()}');
    return _scheduledDateTime;
  }

  Future<void> sheduleNotification(
    Aniversari _aniversari,
    tz.TZDateTime _sheduledDate,
  ) async {
    UILocalNotificationDateInterpretation uilLocalNotDI =
        UILocalNotificationDateInterpretation.absoluteTime;
    flutterLocalNotificationsPlugin.zonedSchedule(
      _aniversari.id,
      "Today is ${_aniversari.nom} ${_aniversari.cognom1} ${_aniversari.cognom2} birthday",
      "Don't forget to congratulate ${_aniversari.nom}",
      _nextInstanceOfNotification(_sheduledDate),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: uilLocalNotDI,
      //payload: DateFormat.yMd().add_Hm().format(sheduledDate));
      payload: DateFormat('dd-MM-yyyy').add_Hm().format(_sheduledDate),
    );
  }

  _nextInstanceOfNotification(tz.TZDateTime _date) {
    if (_date.isBefore(DateTime.now())) {
      _date = _date.add(const Duration(seconds: 5));
    }
    return _date;
  }

/*   void sheduleNotification(Aniversari aniversari) async {
    final date = aniversari.dataNaixement;
    final id = aniversari.id;
    late var sheduledDate;
    late var nextBDay;
    int year = DateTime.now().year;

    late String timeNotification;
    SharedPreferences.getInstance().then((value) {
      if (value.containsKey("notification_hour")) {
        timeNotification = value.getString("notification_hour") ?? '09:00';
      } else {
        timeNotification = '09:00';
      }
      print('timeNotification =' + timeNotification);

      var bDayThisYear = DateTime(
        date.year,
        date.month,
        date.day,
        int.parse(timeNotification.substring(0, 2)),
        int.parse(timeNotification.substring(3, 5)),
      );
      nextBDay = bDayThisYear;
      if (bDayThisYear.isBefore(DateTime.now())) {
        nextBDay = DateTime(
          year + 1,
          date.month,
          date.day,
          int.parse(timeNotification.substring(0, 2)),
          int.parse(timeNotification.substring(3, 5)),
        );
      }

      return timeNotification;
    }).then((value) {
      sheduledDate = tz.TZDateTime.local(
        nextBDay.year,
        nextBDay.month,
        nextBDay.day,
        int.parse(timeNotification.substring(0, 2)),
        int.parse(timeNotification.substring(3, 5)),
      );
      print('scheduledDate =' + sheduledDate.toString());
    }).then((value) {
      UILocalNotificationDateInterpretation uilLocalNotDI =
          UILocalNotificationDateInterpretation.absoluteTime;
      flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          "Today is ${aniversari.nom} ${aniversari.cognom1} ${aniversari.cognom2} birthday",
          "Don't forget to congratulate ${aniversari.nom}",
          sheduledDate,
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: uilLocalNotDI,
          //payload: DateFormat.yMd().add_Hm().format(sheduledDate));
          payload: DateFormat('dd-MM-yyyy').add_Hm().format(sheduledDate));
      print('sheduledDate -------> ' + sheduledDate.toString());
    });
  } */

  void sheduleNewNotification(Aniversari _aniversari) async {
    String _hourNotif = await getTimeNotificationString();
    tz.TZDateTime _nextNotificationDateTime = await setNextNotificationDateTime(
      _aniversari,
      _hourNotif,
    );
    sheduleNotification(_aniversari, _nextNotificationDateTime);
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
    print('listaNotif.lenght=' + listaNotif.length.toString());
    for (int i = 0; i < listaNotif.length; i++) {
      print(
          '${listaNotif[i].id} ${listaNotif[i].title}  ${listaNotif[i].body}  ${listaNotif[i].payload}');
    }
  }

  void editTimeAllNotifications() async {
    List<PendingNotificationRequest> listaNotif =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    //print('listaNotif.lenght=' + listaNotif.length.toString());
    for (int i = 0; i < listaNotif.length; i++) {
      print(
          '${listaNotif[i].id} ${listaNotif[i].title}  ${listaNotif[i].body}  ${listaNotif[i].payload}');
    }
  }
}
