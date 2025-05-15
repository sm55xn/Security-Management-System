class ValidatorFormDataName {
  
      RegExp nameRegExpEnglish = RegExp(r'^([A-Za-z]+)\S(\s\S+[A-Za-z]+){2,}$');
      RegExp nameRegExpArbic = RegExp(r'^([أ-ي]+)\S(\s\S+[أ-ي]+){2,}$');


  bool isValidName(String input) {
    if (nameRegExpEnglish.hasMatch(input)||nameRegExpArbic.hasMatch(input)) {
      return true;
    } else {
      return false;
    }
    
  }
}
