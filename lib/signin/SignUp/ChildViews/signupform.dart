import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({this.emailTextController,
      this.passwordTextController,
      this.nameTextController,
      this.mobileTextController,
      this.confirmPasswordTextController,
      this.parentAction,
      this.isWithSNS});

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController nameTextController;
  final TextEditingController mobileTextController;
  final TextEditingController confirmPasswordTextController;

  final ValueChanged<List<dynamic>> parentAction;

  bool isWithSNS = false;

  @override
  State<StatefulWidget> createState() => _SignUpForm();
}

enum GenderEnum { man, woman }

class _SignUpForm extends State<SignUpForm> with AutomaticKeepAliveClientMixin<SignUpForm> {

  // init data
  GenderEnum _userGender = GenderEnum.man;
  String _selectDateString = 'Select your birthday';
  bool _agreedToTerm = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year-10, DateTime.now().month),
        firstDate: DateTime(DateTime.now().year-19, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year-10, DateTime.now().month, DateTime.now().day));
    if (picked != null && picked != DateTime.now())
      setState(() {
        _selectDateString = "${picked.toLocal()}".split(' ')[0];
        _passDataToParent('birth_year',picked.year);
        _passDataToParent('birth_month',picked.month);
        _passDataToParent('birth_day',picked.day);
      });

    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _setAgreedToTerm(bool newValue) {
    _passDataToParent('term',newValue);
    setState(() {
      _agreedToTerm = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: const EdgeInsets.fromLTRB(14.0,10,14,10),
        padding: const EdgeInsets.fromLTRB(14.0,10,14,10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.all(
              Radius.circular(25.0)
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 360,
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon:Icon(Icons.account_circle),
                    labelText: 'Name',
                    hintText: 'Type Name'
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Name is required';
                  }else {
                    return null;
                  }
                },
                controller: widget.nameTextController,
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Icon(Icons.wc,color: Colors.grey,),
                Radio(
                  value: GenderEnum.man,
                  groupValue: _userGender,
                  onChanged: (GenderEnum value) {
                    setState(() {
                      _passDataToParent('gender','Man');
                      _userGender = value;
                    });
                  },
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _passDataToParent('gender','Man');
                      _userGender = GenderEnum.man;
                    });
                  },
                  child: Text('Man'),
                ),
                SizedBox(width: 20,),
                Radio(
                  value: GenderEnum.woman,
                  groupValue: _userGender,
                  onChanged: (GenderEnum value) {
                    setState(() {
                      _passDataToParent('gender','Woman');
                      _userGender = value;
                    });
                  },
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _passDataToParent('gender','Woman');
                      _userGender = GenderEnum.woman;
                    });
                  },
                  child: Text('Woman'),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              width: 360,
              child:
              Row(
                children: <Widget>[
                  Icon(Icons.cake,color: Colors.grey,),
                  Padding(
                    padding: const EdgeInsets.only(left:14.0),
                    child: Container(
                      width: 260,
                      child: RaisedButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text(_selectDateString),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width: 360,
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon:Icon(Icons.phone),
                  labelText: 'Phone',
                  hintText: 'Type phone number',
                ),
                validator: (String value) {
                  String pattern = r'(^[0-9]*$)';
                  RegExp regExp = new RegExp(pattern);
                  if (value.replaceAll(" ", "").isEmpty) {
                    return 'Mobile is required';
                  } else if (value.replaceAll(" ", "").length != 10) {
                    return 'Mobile number must 10 digits';
                  } else if (!regExp.hasMatch(value.replaceAll(" ", ""))) {
                    return 'Mobile number must be digits';
                  }
                  return null;
                },
                controller: widget.mobileTextController,
              ),
            ),
            Divider(),
            SizedBox(
              width: 360,
              child: TextFormField(
                enabled: !widget.isWithSNS,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.mail, color: !widget.isWithSNS ? Colors.grey : Colors.grey[300],),
                    labelText: 'Email',
                    hintText: 'Type your email'
                ),
                validator: (String value) {
                 String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\'
                     r'.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                 RegExp regExp = new RegExp(pattern);
                 if (value.isEmpty) {
                   return "Email can't be empty";
                 }
                 if (!regExp.hasMatch(value)) {
                   return 'Invalid email';
                 }return null;
                },
                style: TextStyle(color: !widget.isWithSNS ? Colors.black : Colors.grey[400]),
                controller: widget.emailTextController,
              ),
            ),
            Divider(),
            SizedBox(
              width: 360,
              child: TextFormField(
                enabled: !widget.isWithSNS,
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon:Icon(Icons.lock, color: !widget.isWithSNS ? Colors.grey : Colors.grey[300],),
                    labelText: !widget.isWithSNS ? 'Password' : 'Do not need a password',
                    hintText: 'Type password'
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Password is required';
                  }else if (value.length < 6) {
                    return 'password must be at least 6 characters';
                  }
                  else {
                    return null;
                  }
                },
                style: TextStyle(color: !widget.isWithSNS ? Colors.black : Colors.grey[300]),
                controller: widget.passwordTextController,
              ),
            ),
            Divider(),
            SizedBox(
              width: 360,
              child: TextFormField(
                enabled: !widget.isWithSNS,
                obscureText: true,
                validator: (confirmation) {
                  if (confirmation.length < 6) {
                    return 'Confirm password must be at least 6 characters';
                  }
                  return confirmation.isEmpty
                      ? 'Confirm password is required'
                      : validationEqual(confirmation, widget.passwordTextController.text)
                      ? null
                      : 'Password not match';
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon:Icon(Icons.lock, color: !widget.isWithSNS ? Colors.grey : Colors.grey[300],),
                    labelText: !widget.isWithSNS ? 'confirmPassword' : 'Do not need a confirmPassword',
                    hintText: 'Type confirmPassword'
                ),
                style: TextStyle(color: !widget.isWithSNS ? Colors.black : Colors.grey[300]),
                controller: widget.confirmPasswordTextController,
              ),
            ),
            Divider(),
            SizedBox(
              width: 360,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: _agreedToTerm,
                      onChanged: _setAgreedToTerm,
                    ),
                    GestureDetector(
                      onTap: (){
                        _agreedToTerm = !_agreedToTerm;
                        _setAgreedToTerm(_agreedToTerm);
                      },
                      child:
                      Text('I agree to '),
                    ),
                    GestureDetector(
                      onTap: () => _showTermPolicy(),
                      child: const Text(
                        'Terms of Services',
                        style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  void _showTermPolicy() {
    showDialog(context: context, child:
      new AlertDialog(
        title: new Text("Adolescent counseling Terms of Services, Privacy Policy"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          height: 360,
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('1. Insulting is not allowed',textAlign: TextAlign.left),
                Text('2. Do not share false informations',textAlign: TextAlign.left),
                Text('3. Advertising the use of drug is not allowed',textAlign: TextAlign.left),
                Text('4. Do not share personal informations without consent',textAlign: TextAlign.left),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          )
        ],
      )
    );
  }
  bool validationEqual(String currentValue, String checkValue) {
    if (currentValue == checkValue) {
      return true;
    } else {
      return false;
    }
  }

  void _passDataToParent(String key, dynamic value) {
    List<dynamic> addData = List<dynamic>();
    addData.add(key);
    addData.add(value);
    widget.parentAction(addData);
  }

  @override
  bool get wantKeepAlive => true;
}
