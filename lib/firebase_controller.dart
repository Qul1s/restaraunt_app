class FirebaseController{

  String mail = "";
  String phone = "";


  bool setMailOrPhone(String text){
    if(text.contains("@")){
        setMail(text);
        return true;
      }
    else{
        setPhone(text);
        return false;
      }
  }

  void setMail(String newMail){
    mail = newMail; 
  }

  void setPhone(String newPhone){
    phone = newPhone;
  }

  void register(String password, String verifyPasswoprd, bool mail){
    if(password == verifyPasswoprd){
      if(mail){
        registerWithMail(password);
        }
      else{
        registerWithPhone(password);
      }
    }
    else{
      //return "Паролі не збігаються"
    }
  }


  void registerWithPhone(String password){

  }

  void registerWithMail(String password){
    
  }

  void setName(String name){

  }

  void setAge(String age){

  }

}