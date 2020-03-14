class EmailFieldValidator {
  static String validate (String val){
    return val.isEmpty?'Enter an email':null; 
  }
}

class PasswordFieldValidator {
  static String validate (String val){
    return val.length<6?'Enter a password longer than 6 characters':null;
  }
}