import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextFieldWidget'),
      ),
      body: SingleChildScrollView(
        child: new Padding(
          padding: EdgeInsets.all(10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(),
              TextField(
                decoration: InputDecoration(
                  hintText: 'hint message',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone_iphone),
                    hintText: "hintText",
                    labelText: "labelText",
                    labelStyle:
                        TextStyle(color: Colors.deepOrange, fontSize: 14),
                    helperText: "helpText",
                    helperStyle: TextStyle(color: Colors.pink, fontSize: 14),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 20),
                    hasFloatingPlaceholder: true,
                    //labelText是否浮动，默认为true，修改为false则labelText在输入框获取焦点时不会浮动且不显示
                    errorText: 'errorText'), //如果errorText不为空的话,helperText属性设置失效
              ),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_iphone),
                    prefixText: 'prefixText',
                    suffixIcon: Icon(Icons.remove_red_eye),
                    suffixText: 'suffixText'),
              ),
              TextField(
                decoration: InputDecoration(counterText: "counterText"),
              ),
              TextField(
                decoration: InputDecoration(
                    counterText: "0/10",
                    counterStyle: TextStyle(color: Colors.red)),
              ),
              TextField(
                decoration: InputDecoration(
                    fillColor: Colors.pink,
                    filled: true,
                    hintText: 'hintText',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepOrange, width: 2)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  errorBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide:
                          BorderSide(color: Colors.deepOrange, width: 2)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 4),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(),
                keyboardType: TextInputType.phone,
                onTap: () {
                  print('On Tab');
                },
                onChanged: (text) {
                  print("onChanged: "+text);
                },
                onEditingComplete: () {
                  print("onEditingComplete");
                },
                onSubmitted: (text){
                  print('onSubmitted: '+text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
