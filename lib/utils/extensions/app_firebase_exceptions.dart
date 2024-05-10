import 'package:alhikmah_schedule_student/utils/enum/app_firebase_exception_type.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseErrorCode on FirebaseAuthException{
  AppFirebaseExceptionType appFirebaseExceptionType(){
    switch(code){
      case 'invalid-email':
        return AppFirebaseExceptionType.invalidEmail;
      case 'user-disabled':
        return AppFirebaseExceptionType.userDisabled;
      case 'user-not-found':
        return AppFirebaseExceptionType.userNotFound;
      case 'too-many-requests':
        return AppFirebaseExceptionType.tooManyRequests;
      case 'email-already-in-use':
        return AppFirebaseExceptionType.emailAlreadyInUse;
      case 'weak-password':
        return AppFirebaseExceptionType.weakPassword;
      case 'wrong-password':
        return AppFirebaseExceptionType.wrongPassword;
      case 'account-exists-with-different-credential':
        return AppFirebaseExceptionType.accountExists;
      case 'invalid-credential':
        return AppFirebaseExceptionType.invalidCredentials;
      case 'user-mismatch':
        return AppFirebaseExceptionType.userMisMatch;
      case 'network-request-failed':
        return AppFirebaseExceptionType.networkUnavailable;
      default:
        return AppFirebaseExceptionType.none;
    }
  }
}
