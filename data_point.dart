
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:qubot_admin/src/services/firebase/users_firestore.dart';
import 'package:qubot_admin/src/view/general/bloc/general_bloc.dart';

class SaveDataPoint { 
  UsersFirestoreService usersController = UsersFirestoreService();
  FirebaseApp app = Firebase.app('qubotAdmin');
  dynamic dbData;
  List<String> pointsTime = [];
  dynamic pointsData; 
  DateTime pastTimeDate = DateTime.now();
  int removed = 0;
  int errorWhileRemove = 0;

  Future<void> dbReferences(generalBloc) async {
    try {
      dbData = FirebaseDatabase(
        app: app, 
        databaseURL: 'https://...firebaseio.com'
      )
      .reference();
    }  
    on PlatformException catch (e) {
      print('catch: ${e.message}'); 
      generalBloc.add(PointsTimeFailEvent("Something is wrong. Check database connection!"));
    }
    on Exception catch (e) {
      print(e);
      generalBloc.add(PointsTimeFailEvent("Something is wrong. Check database connection!"));
    }
    catch (e) { print('catch: $e'); }
  }

  Future<int> getCounter(point) async {
    int numberUpdates = 0;
    await dbData.child("point_save").child("$point").child("counter").once()
        .then((counter) { numberUpdates = counter.value ?? 0; });
    return numberUpdates;
  }

  saveDataBaseToPoint(int point, generalBloc) async {
    pointsTime = generalBloc.pointsTime;
    print("prepare db to save ${generalBloc.generalUsers.length} profiles...");
    try {
      await dbReferences(generalBloc); 
      int numberUpdates = await getCounter(point) + 1;
      print("numberUpdates: $numberUpdates");
      await dbData.child("point_save").child("$point").child("data").once() 
        .then((dataOnce)
          { 
              print("new point number: $numberUpdates");
              dbData 
                  .child("point_save")
                  .child("$point")
                  .child("counter")
                  .set(
                    numberUpdates
                  );
              generalBloc.generalUsers.forEach((dataObject) async {
                Map valueMap = dataObject.toJson();
                dbData 
                  .child("point_save")
                  .child("$point")
                  .child("data")
                  .child("$numberUpdates")
                  .push()
                  .set(
                    valueMap
                  );
              });
              String dateTimeNow = DateTime.now().millisecondsSinceEpoch.toString();
              print("dateTeme: $dateTimeNow");
              dbData  
                .child("point_save")
                .child("$point")
                .child("timestamp")
                .child("$numberUpdates")
                .set(
                  dateTimeNow
                ).then((_) => {
                  usersController.timestampGet(dbData, generalBloc),
                });
          });
    }
    catch (e) { 
        print('catch: $e'); 
        generalBloc.add(PointsTimeFailEvent("Something is wrong. Check database connection!"));
    }
  }

  cleanDataBasePoints(generalBloc, int point) async {
    dynamic pointsDataTimestampValue;
    await dbReferences(generalBloc);
        await dbData
          .child("point_save")
          .child("$point")
          .child("timestamp")
          .once().then((pointsDataTimestamp) => {
            pointsDataTimestampValue = pointsDataTimestamp.value
          });
    print(pointsDataTimestampValue);
    cleanDataBase(pointsDataTimestampValue, point);
    generalBloc.add(CleanDataBaseEvent());
  }

  cleanDataBase(pointsDataTimestamp, int point) async {
    int pastDateTimeInt = 0;
    String pastKey = "0";
    await pointsDataTimestamp.forEach((key, dateTimeString) {
      int dateTimeInt = int.parse(dateTimeString);
      DateTime timeDate = DateTime.fromMillisecondsSinceEpoch(dateTimeInt);
      Duration difference = pastTimeDate.difference(timeDate);
      print("difference: ${difference.inDays}");
      int differenceDays = difference.inDays;
      if (differenceDays==0 && pastDateTimeInt!=0) {
        removePointByClean(
          pointsDataTimestamp, 
          point, 
          pastKey, 
          pastDateTimeInt
        ).then((_) => {
          removed++
        });
      }
      pastTimeDate = timeDate;
      pastKey = key;
      pastDateTimeInt = dateTimeInt;
    });
  }

  removePointByClean(pointsDataTimestamp, point, i, int pastDateTimeInt) async {
    DateTime timeDate = DateTime.fromMillisecondsSinceEpoch(pastDateTimeInt);
    try {
      await dbData
        .child("point_save")
        .child("$point")
        .child("data")
        .child("$i")
        .remove().then((_) => {
          print("data point sucessfully removed - $i : $timeDate")
        }); 
      await dbData
        .child("point_save")
        .child("$point")
        .child("timestamp")
        .child("$i")
        .remove().then((_) => {
          print("time point sucessfully removed - $i : $timeDate")
        });   
    } catch (e) {
      print(e);
      errorWhileRemove++;
      print("errors while cleaning data points: $errorWhileRemove");
    }
  }
}