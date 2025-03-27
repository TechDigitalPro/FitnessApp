class ApiUtils {
  // ignore: non_constant_identifier_names
  // static String BASE_URL = 'http://192.168.100.75/fitness/mobile/';
  // ignore: non_constant_identifier_names
  static String BASE_URL = 'https://nxtlvl.leadmarketer.com/api/public/';

  // Auth
  static String urlLogin = '${BASE_URL}auth/login';
  static String urlRegister = '${BASE_URL}auth/register';
  static String urlForgotPassword = '${BASE_URL}auth/user/resetpw';
  static String urlVerifyEmail = '${BASE_URL}auth/user/verify';
  static String urlResendVerificationEmail = '${BASE_URL}auth/user/resend';
  
  // Trainers
  static String urlGetTrainerList = '${BASE_URL}auth/trainers/all';
  
  // Workouts
  static String urlGetWorkoutList = '${BASE_URL}auth/workouts/all';

  // News
  static String urlGetNewsList = '${BASE_URL}auth/news/all';

  // Plans
  static String urlGetPlanList = '${BASE_URL}auth/plans/all';
  static String urlSetPlan = '${BASE_URL}auth/clients/setplan';
    
  // Plans
  static String urlGetPackagesList = '${BASE_URL}auth/packages/all';

  static String urlImagePre = '${BASE_URL}auth/download?fileName=';
  static String urlVideoPre = '${BASE_URL}auth/download?fileName=';
  
}
