import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  _sendEmail();
                },
                child: const Text(
                  '건의사항 보내기',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Divider(
              height: 1,
              indent: 10,
              //color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  void _sendEmail() async {
    String body = await _getEmailBody();

    final Email email = Email(
      body: body,
      subject: '[다너다너 문의]',
      recipients: ['qmak01@naver.com'],
      //cc: [],
      //bcc: [],
      //attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title =
          '기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.\n\n아래 이메일로 연락주시면 답변드리겠습니다. \n\nqmak01@naver.com';
      String message = '';
      _showErrorAlert(title: title, message: message);
    }
  }

  void _showErrorAlert({required String title, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title,
              style: const TextStyle(
                fontSize: 15,
              )),
        );
      },
    );
  }

  Future<String> _getEmailBody() async {
    Map<String, dynamic> deviceInfo = await _getDeviceInfo();
    Map<String, dynamic> appInfo = await _getAppInfo();

    String body = '\n\n\n\n';

    body += "==========================\n";
    body += '아래 내용을 함께 보내주시면 큰 도움이 됩니다 \n';

    deviceInfo.forEach((key, value) {
      body += '$key: $value \n';
    });
    appInfo.forEach((key, value) {
      body += '$key: $value \n';
    });

    body += "==========================\n";
    return body;
  }

  Future<Map<String, dynamic>> _getAppInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return {'다너다너 버전': info.version};
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidDeviceInfo(await deviceInfo.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfo.iosInfo);
      }
    } catch (error) {
      deviceData = {"Error": "Failed to get platform version"};
    }

    return deviceData;
  }

  Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo info) {
    var release = info.version.release;
    var sdkInt = info.version.sdkInt;
    var manufacturer = info.manufacturer;
    var model = info.model;

    return {
      'OS 버전': 'Android $release (SKD $sdkInt)',
      '기기': '$manufacturer $model'
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    var systemName = info.systemName;
    var version = info.systemVersion;
    var machine = info.utsname.machine?.iOSProductName;

    //print('${info.toMap()}');
    return {'OS 버전': '$systemName $version', '기기': '$machine'};
  }
}
