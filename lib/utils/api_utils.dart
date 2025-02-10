class ApiUtils {
  // ignore: non_constant_identifier_names
  // static String BASE_URL = 'http://192.168.100.75/fitness/mobile/';
  // ignore: non_constant_identifier_names
  static String BASE_URL = 'https://nxtlvl.leadmarketer.com/api/public/mobile/';

  // Auth
  static String urlLogin = '${BASE_URL}user/login';
  static String urlRegister = '${BASE_URL}user/register';
  static String urlForgotPassword = '${BASE_URL}user/resetpw';
  static String urlVerifyEmail = '${BASE_URL}user/verify';
  static String urlResendVerificationEmail = '${BASE_URL}user/resend_code';
  
  // Trainers
  static String urlGetTrainerList = '${BASE_URL}trainer/all';
  
  // Workouts
  static String urlGetWorkoutList = '${BASE_URL}workout/getWorkoutList';

  static String urlImagePre = BASE_URL.replaceAll('mobile/', 'images/');
  static String urlVideoPre = BASE_URL.replaceAll('mobile/', 'videos/');
  
}
