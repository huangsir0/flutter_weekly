import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


GlobalKey<_FreeLocalizations> freeLocalizationStateKey = new GlobalKey<_FreeLocalizations>();
class AppNationalizeNormal extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate, //提供了 Material 组件库所使用的字符串资
        GlobalWidgetsLocalizations.delegate, //定义了在当前的语言中，文字默认的排列方向。
        SimpleLocalizationsDelegate.delegate, //加入自定义委托
      ],
      supportedLocales: [
        const Locale('en', 'US'), //英文
        const Locale('zh', 'CN'), //中文
      ],

      // title: SimpleLocalizations.of(context).appTitle,
      onGenerateTitle: (context) {
        return SimpleLocalizations.of(context).appTitle;
      },
      theme: ThemeData(primaryColor: Colors.redAccent),
      //home: HomePage(),
      home: Builder(builder: (context){
        return new FreeLocalizations(
          key: freeLocalizationStateKey,
          child: HomePage(),
        );
      },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool flag=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SimpleLocalizations.of(context).appName),
      ),
      body: Center(
        child: Text(SimpleLocalizations.of(context).helloWorld),
      ),
    floatingActionButton: FloatingActionButton(onPressed: (){
      if(flag){
        freeLocalizationStateKey.currentState.changeLocale(const Locale('zh',"CH"));
      }else{
        freeLocalizationStateKey.currentState.changeLocale(const Locale('en',"US"));
      }
      flag = !flag;
    },child: Icon(Icons.refresh),),
    );
  }
}



//接下来我们要做一个类似GlobalWidgetsLocalizations的委托
class SimpleLocalizations {
  SimpleLocalizations(this.locale);

  final Locale locale;

  //of这个静态方法就会返回 SimpleLocalizations 的实例
  static SimpleLocalizations of(BuildContext context) {
    return Localizations.of<SimpleLocalizations>(context, SimpleLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'FlutterApp Title',
      'app_name': 'App Name',
      'hello_world': 'Hello World',
    },
    'zh': {
      'app_title': 'FlutterApp 标题',
      'app_name': '应用名',
      'hello_world': '你好世界',
    },
  };

  Map<String, String> get _stringMap {
    return _localizedValues[locale.languageCode];
  }

  String get helloWorld {
    return _stringMap['hello_world'];
  }

  String get appTitle {
    return _stringMap['app_title'];
  }

  String get appName {
    return _stringMap['app_name'];
  }
}

//从上面的代码可以看到，这种方法的原理非常简单，就是将所有字符串放进 map，然后通过应用的 Locale 来取出对应语言的字符串。使用时，就是 SimpleLocalizations.of(context).helloWorld 这样来引用字符串。
//以上定义的SimpleLocalizations类交给一个委托类来初始化。所以我们还得再定义一个类。

class SimpleLocalizationsDelegate
    extends LocalizationsDelegate<SimpleLocalizations> {
  const SimpleLocalizationsDelegate();

  static SimpleLocalizationsDelegate delegate =
      const SimpleLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  //SimpleLocalizations 在此方法内被初始化的。
  @override
  Future<SimpleLocalizations> load(Locale locale) {
    return SynchronousFuture<SimpleLocalizations>(SimpleLocalizations(locale));
  }

  @override
  bool shouldReload(SimpleLocalizationsDelegate old) => false;
}
//接下来如何使用?
//SimpleLocalizations.of(context).appName

//Flutter内部切换语言
class FreeLocalizations extends StatefulWidget{

  final Widget child;

  FreeLocalizations({Key key,this.child}):super(key:key);

  @override
  State<FreeLocalizations> createState() {
    return new _FreeLocalizations();
  }
}

class _FreeLocalizations extends State<FreeLocalizations>{

  Locale _locale = const Locale('zh','CH');

  changeLocale(Locale locale){
    setState((){
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