  
import 'package:cloud_firestore/cloud_firestore.dart';

class TimeFormatHelper {

    static String convertDate(String timestamp) {
      int hour = Timestamp.fromMillisecondsSinceEpoch(int.parse(timestamp))
          .toDate()
          .hour;
      int min = Timestamp.fromMillisecondsSinceEpoch(int.parse(timestamp))
          .toDate()
          .minute;
      int day =
          Timestamp.fromMillisecondsSinceEpoch(int.parse(timestamp)).toDate().day;
      int month = Timestamp.fromMillisecondsSinceEpoch(int.parse(timestamp))
          .toDate()
          .month;
      int year = Timestamp.fromMillisecondsSinceEpoch(int.parse(timestamp))
          .toDate()
          .year;
      int currentDay = Timestamp.now().toDate().day;
      int currentMonth = Timestamp.now().toDate().month;
      int currentYear = Timestamp.now().toDate().year;
      if (day == currentDay && month == currentMonth && year == currentYear) {
        String afternoon = "AM";
        if (hour >= 12) {
          afternoon = "PM";
          hour = hour - 12;
        }
        if (min < 10) {
          return hour.toString() + ":" + "0" + min.toString() + " " + afternoon;
        }
        return hour.toString() + ":" + min.toString() + " " + afternoon;
      } else {
        String monthNameAndDate = convertDateDayShort(timestamp);
        return monthNameAndDate;
      }
    }

    static String convertDateDay(String timestamp) {
      int day = Timestamp.fromMillisecondsSinceEpoch(int.parse(timestamp)).toDate().day;
      int monthInt = Timestamp.fromMillisecondsSinceEpoch(int.parse(timestamp))
          .toDate()
          .month;
      String month = "";
        switch (monthInt) {
          case 1:
            month = "January";
            break;
          case 2:
            month = "February";
            break;
          case 3:
            month = "March";
            break;
          case 4:
            month = "April";
            break;
          case 5:
            month = "May";
            break;
          case 6:
            month = "June";
            break;
          case 7:
            month = "July";
            break;
          case 8:
            month = "August";
            break;
          case 9:
            month = "September";
            break;
          case 10:
            month = "October";
            break;
          case 11:
            month = "November";
            break;
          case 12:
            month = "December";
            break;
        }
      String dateString = month + " " + day.toString();   
      return dateString;   
    }

    static String convertDateDayShort(String timestamp) {
      int day = Timestamp.fromMillisecondsSinceEpoch(int.parse(timestamp)).toDate().day;
      int monthInt = Timestamp.fromMillisecondsSinceEpoch(int.parse(timestamp))
          .toDate()
          .month;
      String month = "";
        switch (monthInt) {
          case 1:
            month = "Jan";
            break;
          case 2:
            month = "Feb";
            break;
          case 3:
            month = "Mar";
            break;
          case 4:
            month = "Apr";
            break;
          case 5:
            month = "May";
            break;
          case 6:
            month = "Jun";
            break;
          case 7:
            month = "Jul";
            break;
          case 8:
            month = "Aug";
            break;
          case 9:
            month = "Sep";
            break;
          case 10:
            month = "Oct";
            break;
          case 11:
            month = "Nov";
            break;
          case 12:
            month = "Dec";
            break;
        }
      String dateString = month + " " + day.toString();   
      return dateString;   
    }
  }