import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:word_word/boxes.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with TickerProviderStateMixin {
  final blogUrl = 'https://blog.naver.com/qmak01';
  final dicKoreanUrl = 'https://stdict.korean.go.kr/main/main.do';
  final dicUrimalUrl = 'https://opendict.korean.go.kr/main';
  final instaUrl = 'https://www.instagram.com/2cup_2/';
  late final AnimationController _controller;
  final Completer<WebViewController> webController = Completer<WebViewController>();

  bool _isInstaVisible = false;

  Widget webView(String url) {
    return SafeArea(
      child: WebView(
        initialUrl: url,
        onWebViewCreated: (WebViewController _controller) async {
          webController.isCompleted ? '' : webController.complete(_controller);
        },
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              //color: const Color(0xffa1df6e),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )),
              child: Center(
                child: Text(
                  '다너다너',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontFamily: 'KoPubBatang',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                      letterSpacing: 4),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: TextButton(
            //     style: ButtonStyle(
            //       foregroundColor: MaterialStateProperty.all(textColor),
            //       padding: MaterialStateProperty.all(EdgeInsets.zero),
            //     ),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //     child: const Icon(
            //       Icons.arrow_back,
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => webView(dicKoreanUrl)));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '표준국어대사전 바로가기',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => webView(dicUrimalUrl)));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '우리말 샘 바로가기',
                    style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            //SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  _sendEmail();
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '건의사항 보내기',
                    style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => webView(blogUrl)));
                      // _openUrl(blogUrl);
                      setState(() {
                        _isInstaVisible = true;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          '개발자 블로그',
                          style: TextStyle(fontSize: 17, color: Theme.of(context).primaryColorDark),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Image(
                            width: 20,
                            height: 20,
                            image: AssetImage('assets/images/naver_blog_icon.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isInstaVisible)
                  // const Padding(
                  //   padding: EdgeInsets.all(5),
                  //   child: Image(
                  //     width: 17,
                  //     height: 17,
                  //     image: AssetImage('assets/images/instagram_icon.png'),
                  //   ),
                  // ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(20, 20),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      _openUrl(instaUrl);
                    },
                    child: const Image(
                      alignment: Alignment.centerLeft,
                      width: 20,
                      height: 20,
                      image: AssetImage('assets/images/instagram_icon.png'),
                    ),
                  ),
              ],
            ),
            const Divider(
              height: 1,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text(
                          '다너다너 초기화',
                          style: TextStyle(fontSize: 17, color: Colors.red),
                        ),
                        content: const Text('다너다너를 초기화 하시겠습니까?'),
                        actions: [
                          CupertinoDialogAction(
                              child: const Text(
                                '취소',
                                //style: TextStyle(color: Colors.red), // 왜 적용 안되지
                              ),
                              onPressed: () => Navigator.pop(context)),
                          CupertinoDialogAction(
                            child: const Text(
                              '초기화',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              RecentWordBoxes.getWords().clear();
                              WordBoxes.getWords().clear();
                              Navigator.pop(context);
                              const snackBar = SnackBar(
                                content: Text('다너다너가 초기화 되었습니다!'),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                          )
                        ],
                      );
                    },
                    barrierDismissible: true,
                  );
                },
                child: Text(
                  '다너다너 초기화',
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
            ),
            //Expanded(child: SizedBox(height: 0)),
            Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    Text(
                        '본 사전은 표준국어대사전 OpenAPI를 통해 제작되었으며,\n모든 사전정보의 저작권은 국립국어원에 있습니다.\n\n언뜻 스친 단어를 담아\n사색하고 음미하는 시간이 되었으면 좋겠습니다.'),
                  ],
                )),
            Center(
              child: Lottie.asset(
                'assets/lottie/lf30_editor_to6nvmre.json',
                repeat: true,
                height: 100,
                controller: _controller,
                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  _controller
                    ..duration = composition.duration
                    ..forward();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //url 메소
  void _openUrl(String url) async {
    //await launch(url, forceWebView: false, forceSafariVC: false);
  }

  //메일 메소드들
  void _sendEmail() async {
    String body = await _getEmailBody();

    final Email email = Email(
      body: body,
      subject: '[다너다너 문의]',
      recipients: ['qmak01@naver.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      // String title = '메세지 전송 완료!';
      // String message = '';
      // _showErrorAlert(title: title, message: message);
    } catch (error) {
      debugPrint(error.toString());
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

    String body = '';

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

    return {'OS 버전': 'Android $release (SKD $sdkInt)', '기기': '$manufacturer $model'};
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    var systemName = info.systemName;
    var version = info.systemVersion;
    var machine = info.utsname.machine?.iOSProductName;

    //print('${info.toMap()}');
    return {'OS 버전': '$systemName $version', '기기': '$machine'};
  }
}
