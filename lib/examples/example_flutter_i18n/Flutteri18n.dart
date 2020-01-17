import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_weekly/generated/i18n.dart';



GlobalKey<_FreeLocalizations> freeLocalizationStateKey =
new GlobalKey<_FreeLocalizations>(); //

class Flutteri18n extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        //如果你在使用 material library，需要添加下面两个delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new Builder(builder: (context) {
        return new FreeLocalizations(
          key: freeLocalizationStateKey,
          child: new MyHomePage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool flag = true;

  void changeLocale() {
    if (flag) {
      freeLocalizationStateKey.currentState
          .changeLocale(const Locale('zh', "CN"));
    } else {
      freeLocalizationStateKey.currentState
          .changeLocale(const Locale('en', ""));
    }
    flag = !flag;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text(S.of(context).app_title), // 此处
        ),
        body: Center(
          child: Text(
            S.of(context).hello_world,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: changeLocale,
          child: Icon(Icons.refresh),
        )); // Th
  }
}

class FreeLocalizations extends StatefulWidget {
  final Widget child;

  FreeLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<FreeLocalizations> createState() {
    return new _FreeLocalizations();
  }
}

class _FreeLocalizations extends State<FreeLocalizations> {
  Locale _locale = const Locale('en', '');

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}