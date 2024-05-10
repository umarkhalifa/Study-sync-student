import 'package:alhikmah_schedule_student/utils/enum/app_firebase_exception_type.dart';

extension AuthErrorCode on AppFirebaseExceptionType{
  String toText(){
    switch(this){
      case AppFirebaseExceptionType.invalidEmail:
        return "Invalid Email Address";
      case AppFirebaseExceptionType.userDisabled:
        return "Invalid email or password";
      case AppFirebaseExceptionType.userNotFound:
        return "Invalid email or password";
      case AppFirebaseExceptionType.tooManyRequests:
        return 'Multiple wrong attempts. Please try again later';
      case AppFirebaseExceptionType.emailAlreadyInUse:
        return "User already exits";
      case AppFirebaseExceptionType.wrongPassword:
        return "Invalid email or password";
      case AppFirebaseExceptionType.accountExists:
        return "User already exists";
        case AppFirebaseExceptionType.invalidCredentials:
          return "Invalid email or password";
      case AppFirebaseExceptionType.userMisMatch:
        return "Invalid email or password";
      case AppFirebaseExceptionType.networkUnavailable:
        return "Poor network connection.Please try again";
      default:
        return "Poor network connection. Please try again";


    }
  }
}