import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bad_dad_jokes/dad_types.dart';
import 'package:bad_dad_jokes/joke_service.dart';
import 'package:bad_dad_jokes/joke_widget.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((orientation) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bad Dad Joke',
      home: Scaffold(
        appBar: PreferredSize(
            child: JokeAppBar(), preferredSize: Size(double.maxFinite, 54)),
        body: MyHomePage(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey _globalKey = new GlobalKey();
  final service = JokeService();

  Future<String> getAJoke() async {
    return service.getOne();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAJoke(),
      builder: (context, snapshot) {
        return Stack(
          children: <Widget>[
            SafeArea(
              child: snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done
                  ? RepaintBoundary(key: _globalKey,
                      child: Joke(text: snapshot.data, typeOfDad: DadTypes.random()),
                    )
                  : Container(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: buildBottomBar(
                  snapshot.data,
                  snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done),
            ),
            snapshot.hasData && snapshot.connectionState == ConnectionState.done
                ? Container()
                : Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                    ),
                  )
          ],
        );
      },
    );
  }

  Widget buildBottomBar(String joke, bool enabled) {
    print(enabled);
    return SizedBox(
      width: double.maxFinite,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildShareButton(enabled),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildCopyButton(enabled, joke),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildRefreshButton(enabled),
            )
          ],
        ),
      ),
    );
  }

  IconButton _buildRefreshButton(bool enabled) {
    return IconButton(
      icon: Icon(Icons.refresh),
      tooltip: 'Crack a new one!',
      color: Colors.black.withOpacity(0.5),
      disabledColor: Colors.black12,
      onPressed: enabled
          ? () {
              setState(() {});
            }
          : null,
    );
  }

  IconButton _buildCopyButton(bool enabled, String joke) {
    return IconButton(
      icon: Icon(Icons.content_copy),
      color: Colors.black.withOpacity(0.5),
      disabledColor: Colors.black12,
      onPressed: enabled
          ? () {
              Clipboard.setData(ClipboardData(text: joke)).then((data) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Joke coppied to clipboard',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.blueAccent,
                ));
              });
            }
          : null,
      tooltip: 'Copy to clipboard',
    );
  }

  IconButton _buildShareButton(bool enabled) {
    return IconButton(
      icon: Icon(Icons.share),
      color: Colors.black.withOpacity(0.5),
      disabledColor: Colors.black12,
      onPressed: enabled
          ? () async {
              RenderRepaintBoundary boundary =
                  _globalKey.currentContext.findRenderObject();
              ui.Image image = await boundary.toImage(pixelRatio: 3.0);
              ByteData byteData =
                  await image.toByteData(format: ui.ImageByteFormat.png);
              await EsysFlutterShare.shareImage('img.png', byteData, 'title');
            }
          : null,
      tooltip: 'Share Image',
    );
  }
}

class JokeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Platform.isAndroid
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  tooltip: 'Exit App',
                  onPressed: () {
                    SystemNavigator.pop();
                  })
              : Container(),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              'Bad Joke',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Sarabun',
                  color: Colors.blueAccent),
            ),
          )
        ],
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );
  }
}
