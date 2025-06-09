
import 'package:enough_mail/enough_mail.dart';

class MailModel {
  //TODO flags

  late int _uid;
  late String _date;
  late String _sender;
  late String _subject;
  late String _plainText;

  MailModel(MimeMessage message) {
    _uid = message.uid ?? -1;
    _date = message.decodeDate()!.toIso8601String();
    _sender = message.fromEmail ?? "unknown";
    _subject = message.decodeSubject() ?? '';
    _plainText = message.decodeTextPlainPart() ?? '';
  }

  int get uid => _uid;

  String get date => _date;

  String get sender => _sender;

  String get subject => _subject;

  String get plainText => _plainText;

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();

    map['uid'] = _uid;
    map['date'] = _date;
    map['sender'] = _sender;
    map['subject'] = _subject;
    map['plainText'] = _plainText;

    return map;
  }

  MailModel.fromMapObject(Map<String, dynamic> map) {
    _uid = map['uid'];
    _date = map['date'];
    _sender = map['sender'];
    _subject = map['subject'];
    _plainText = map['plainText'];
  }

  @override
  String toString() {
    return "uid: $_uid, date: $_date, sender: $_sender, subject: $_subject";
  }
}
