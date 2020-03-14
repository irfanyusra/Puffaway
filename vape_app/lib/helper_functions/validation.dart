class EmailFieldValidator {
  static String validate (String val){
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);

    if (val.isEmpty)
    return 'Enter an email';
    else if (!regex.hasMatch(val))
      return 'Enter a Valid Email';
    else
      return null;
  }
}

class PasswordFieldValidator {
  static String validate (String val){
    return val.length<6?'Enter a password longer than 6 characters':null;
  }
}