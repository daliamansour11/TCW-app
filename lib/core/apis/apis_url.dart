class ApiUrl {
  static const String baseImageUrl = 'https://tcw.de-mo.cloud';
  static const String baseUrl = 'https://tcw.de-mo.cloud/api';
  static const String baseVideoUrl = 'https://tcw.de-mo.cloud/storage/app/public/';
  static const auth = _AuthEndpoints();
  static const profile = _ProfileEndpoints();
  // Endpoints for course-related operations.
  static const course = _CourseEndpoints();
  static const studentCourse = _StudentCourseEndpoints();
  static const reels = _ReelEndpoints();
  static const notification = _NotificationEndpoints();
  static const events = _EventEndpoints();
}

/// Endpoints for authentication-related operations.
class _AuthEndpoints {
  const _AuthEndpoints();

  String get login => '${ApiUrl.baseUrl}/auth/student/login';
  String get register => '${ApiUrl.baseUrl}/auth/student/register';
  String get logout => '${ApiUrl.baseUrl}/auth/student/logout';
  String get forgetPassword => '${ApiUrl.baseUrl}/auth/student/forget-password';
  String get verifyToken => '${ApiUrl.baseUrl}/auth/student/verify-token';
  String get resetPassword => '${ApiUrl.baseUrl}/auth/student/reset-password';
}

/// Endpoints for profile-related operations.
class _ProfileEndpoints {
  const _ProfileEndpoints();

  String get base => '${ApiUrl.baseUrl}/student';
  String get getProfile => '$base/profile';
  String get updateProfile => '$base/profile';
  String get updateFirebaseToken => '$base/firebase-token';
  String get deleteMyAccount => '$base/profile';
}

/// Endpoints for student course-related operations.
class _StudentCourseEndpoints {
  const _StudentCourseEndpoints();

  String get base => '${ApiUrl.baseUrl}/student/course';

  String get getCourses =>'$base/';
  String get getLastViewed => '$base/last-viewed';
  String get updateLastViewed => '$base/last-viewed';
  String getCourseClassRoomDetails(int courseId) => '$base/classroom-/$courseId';
  String getCertificate(int courseId) => '$base/certificate/$courseId';
  String getLesson(int courseId) => '${ApiUrl.baseUrl}/student/lesson-resource/$courseId';
  String  getCourseDetails (int courseId) => '$base/details/$courseId';

  String get getCourseTasks => '${ApiUrl.baseUrl}/student/assignment';
  String getCourseTasksDetails(int courseId) => '${ApiUrl.baseUrl}/student/assignment/$courseId';

}

/// Endpoints for course-related operations.
class _CourseEndpoints {
  const _CourseEndpoints();

  String get base => '${ApiUrl.baseUrl}/course';

  String get getCourses => base;
  String get getCategories => '$base-category';
  String  getCourseDetails (int courseId) => '$base/details/$courseId';
  String getCourseLesson(int courseId) => '${ApiUrl.baseUrl}/student/lesson-resource/$courseId';

}class _NotificationEndpoints {
  const _NotificationEndpoints();

  String get base => '${ApiUrl.baseUrl}/push-notification';
  String getNotification(String receiverType) => '$base?receiver_type=$receiverType';

}



/// Endpoints for course-related operations.
class _ReelEndpoints {
  const _ReelEndpoints();

  String get base => '${ApiUrl.baseUrl}/reels';


}
class _EventEndpoints {
  const _EventEndpoints();

  String get base => '${ApiUrl.baseUrl}/events';
  String  getEventDetails (int eventId) => '$base/events/$eventId';



}

