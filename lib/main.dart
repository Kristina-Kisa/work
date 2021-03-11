import 'package:flutter/material.dart';

enum GenderList {male, female}

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  GenderList _gender;
  bool _agreement = false;

  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10.0), child: new Form(key: _formKey, child: new Column(children: <Widget>[
      new Text('Имя пользователя:', style: TextStyle(fontSize: 20.0),),
      new TextFormField(validator: (value){
        if (value.isEmpty) return 'Пожалуйста введите свое имя';
      }),

      new SizedBox(height: 20.0),

      new Text('E-mail:', style: TextStyle(fontSize: 20.0),),
      new TextFormField(validator: (value){
        if (value.isEmpty) return 'Пожалуйста введите свой Email';

        String p = "[a-zA-Z0-9]@[a-zA-Z0-9].[a-zA-Z0-9]";
        RegExp regExp = new RegExp(p);

        if (regExp.hasMatch(value)) return null;

        return 'Это не E-mail';
      }),

      new SizedBox(height: 20.0),

      new Text('Ваш пол:', style: TextStyle(fontSize: 20.0),),

      new RadioListTile(
        title: const Text('Мужской'),
        value: GenderList.male,
        groupValue: _gender,
        onChanged: (GenderList value) {setState(() { _gender = value;});},
      ),

      new RadioListTile(
        title: const Text('Женский'),
        value: GenderList.female,
        groupValue: _gender,
        onChanged: (GenderList value) {setState(() { _gender = value;});},
      ),

      new SizedBox(height: 20.0),

      new CheckboxListTile(
          value: _agreement,
          title: new Text('Я ознакомлен'+(_gender==null?'(а)':_gender==GenderList.male?'':'а')+' с документом.'),
          onChanged: (bool value) => setState(() => _agreement = value)
      ),

      new SizedBox(height: 20.0),

      new RaisedButton(onPressed: (){
        if(_formKey.currentState.validate()) {
          Color color = Colors.deepOrange;
          String text;

          if (_gender == null) text = 'Выберите свой пол';
          else if (_agreement == false) text = 'Необходимо принять условия соглашения';
          else {text = ('Форма успешно заполнена');  color = Colors.blueGrey;}

          Scaffold.of(context).showSnackBar(SnackBar(content: Text(text), backgroundColor: color,));
        }
      },
        child: Text('Проверить'), color: Colors.blue, textColor: Colors.white,),

      RaisedButton(
        child: Text('Open Form'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return DetailScreen();
            }),
          );
        },
      )
    ],)));
  }
}


class DetailScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEXT'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [


            SizedBox (height: 20),
            new RaisedButton( onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if(_formKey.currentState.validate()) return { Navigator.pop(context) };
            }, child: Text ('Back'), color: Colors.blue[500], textColor: Colors.white),


          ],



        ),
      ),
    );
  }
}

void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Form')),
            body: new MyForm(),

        )
    )
);


