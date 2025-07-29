

import 'package:helloagain/constant.dart';
import 'package:intl/intl.dart';

class UtilDateTime {
  static DateTime stringToDateTime(String input) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final currentDate = dateFormat.format(DateTime.now());
    final currentDateTime = currentDate + " " + input;
    print(currentDateTime);

    DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd hh:mm a");
    return dateTimeFormat.parse(currentDateTime);
  }

  static String dateTimeToStringWithFormat(
      DateTime currentDateTime, String format) {
    DateFormat dateTimeFormat = DateFormat(format);
    return dateTimeFormat.format(currentDateTime) ?? "";
  }

  static DateTime stringDateTimeToDateTimeWithFormat(
      String input, String format) {
    DateFormat dateTimeFormat = DateFormat(format);
    return dateTimeFormat.parse(input, true);
  }

  static int getDateDifference(String input, String format) {
    final setDate = stringDateTimeToDateTimeWithFormat(input, format);
    final todayDate = DateTime.now();
    final difference = setDate.difference(todayDate).inDays;

    return difference;
  }

  static String getCurrentDate() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final currentDate = dateFormat.format(DateTime.now());
    return currentDate;
  }

  static String getCurrentTime() {
    DateFormat dateFormat = DateFormat("hh:mm a");
    final currentTime = dateFormat.format(DateTime.now().toUtc());
    return currentTime;
  }

  static String getDateTimeString(String formatString) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(formatString).format(now);

    return formattedDate;
  }

  static DateTime stringDateTimeToDateTime(String input) {
    DateTime date = DateTime.parse(input);
    return date;
  }

  // static String getTimeAgo(String dateTime) {
  //   if (dateTime == "") {
  //     return "";
  //   }
  //
  //   try {
  //     final now = DateTime.now();
  //     var locale = 'en';
  //
  //     final difference = now.difference(
  //         UtilDateTime.stringDateTimeToDateTimeWithFormat(
  //             dateTime ?? now, "yyyy-MM-dd hh:mm a"));
  //     final value = timeago.format(now.subtract(difference), locale: locale);
  //
  //     return value;
  //   } catch (ex) {}
  //
  //   return "";
  // }

  // static String getTimeAgoWithFormat(String dateTime, String dateTimeFormat) {
  //   if (dateTime == "") {
  //     return "";
  //   }
  //
  //   try {
  //     final now = DateTime.now();
  //     var locale = 'en';
  //
  //     final difference = now.difference(
  //         UtilDateTime.stringDateTimeToDateTimeWithFormat(
  //             dateTime, dateTimeFormat));
  //
  //     final value = timeago.format(now.subtract(difference), locale: locale);
  //
  //     return value;
  //   } catch (ex) {}
  //
  //   return "";
  // }

  static int getHourlyIndex(String currentTime) {

    String fCurrentTime = "1970-01-01 $currentTime";

    int returnValue = 0;

    var sortedByKeyMap = Map.fromEntries(
        hourlyMap.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    for (var key in sortedByKeyMap.keys) {
      //hourlyMap.forEach((key, value) {
      List<String> timeSplit = hourlyMap[key]?.split("-") ?? [];
      DateTime nowTime = stringToTimeOfDay(fCurrentTime);
      //print("$fCurrentTime to  ${nowTime.toString()}");

      String fStartTime = "1970-01-01 ${timeSplit[0].trim()}";
      DateTime startTime = stringToTimeOfDay(fStartTime);
      //print("$startTime to  $fStartTime");

      String fEndTime = "1970-01-01 ${timeSplit[1].trim()}";
      DateTime endTime = stringToTimeOfDay(fEndTime);
      //print("$endTime to  $fEndTime");


      if (isValidTimeRange(nowTime, startTime, endTime) == true) {
        returnValue = key;
        break;
      }
    }

    return returnValue;
  }

  static bool isValidTimeRange(
      DateTime now, DateTime startTime, DateTime endTime) {
    return ((now.hour > startTime.hour) ||
            (now.hour == startTime.hour && now.minute >= startTime.minute)) &&
        ((now.hour < endTime.hour) ||
            (now.hour == endTime.hour && now.minute <= endTime.minute));
  }

  static DateTime stringToTimeOfDay(String tod) {
    //final format = DateFormat.jm(); //"6:00 AM"
    return
        stringDateTimeToDateTimeWithFormat(tod, "yyyy-mm-dd hh:mm aa");
  }
}
