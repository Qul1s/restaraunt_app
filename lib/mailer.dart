// ignore_for_file: avoid_print

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void sendToMail(String mail, int code) async {
  // Note that using a username and password for gmail only works if
  // you have two-factor authentication enabled and created an App password.
  // Search for "gmail app password 2fa"
  // The alternative is to use oauth.
  String username = 'inaverifservices@gmail.com';
  String password = 'sjsiobmtrfuidljn';

  // ignore: deprecated_member_use
  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.  

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Pizza Pub')
    ..recipients.add(mail)
    ..subject = 'Verification code 😀'
    ..text = 'Verification code for Pizza Pub: $code';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: $sendReport');
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE
}