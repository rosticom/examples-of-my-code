
import 'package:qantbot/helpers/types.dart';

class QubotUser {
  final String fullName;
  final String photoUrl;
  final String nameShort;
  final double rank;
  final int absRate;

  final String view;
  final String mess;
  final String job;
  final String seal;
  final String country;

  final String desire;
  final String question;
  final String signedIn;

  final GridListType gridType;
  final LanguageType langType;

  QubotUser({
    this.fullName, this.photoUrl, this.nameShort, this.rank, this.absRate, 
    this.view, this.mess, this.job, this.seal, this.country, 
    this.desire, this.question, this.signedIn,
    this.gridType, this.langType
  });

  Map<String, dynamic> toJson() => {
      'fullName': fullName,
      'photoUrl': photoUrl,
      'nameShort': nameShort,
      'rank': rank,
      'absRate': absRate,
      'view': view,
      'mess': mess,
      'job': job,
      'seal': seal,
      'country': country,
      'desire_1': desire,
      'question_1': question,
      'signedIn': signedIn,
      'gridType': gridType,
      'lang': langType
  };

  factory QubotUser.fromJson(Map<String, dynamic> parsedJson) {
    return QubotUser(
      fullName: parsedJson['fullName'],
      photoUrl: parsedJson['photoUrl'],
      nameShort: parsedJson['nameShort'],
      rank: parsedJson['rank'],
      absRate: parsedJson['absRate'],
      view: parsedJson['view'],
      mess: parsedJson['mess'],
      job: parsedJson['job'],
      seal: parsedJson['seal'],
      country: parsedJson['country'],
      desire: parsedJson['desire_1'],
      question: parsedJson['question_1'],
      signedIn: parsedJson['signedIn'],
      gridType: parsedJson['gridType'],
      langType: parsedJson['langType'],
    );
  }
}