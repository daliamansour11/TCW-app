class ApiUrl {
  static const String baseUrl = 'https://tcw.de-mo.cloud/api';

  static const auth = _AuthEndpoints();
  // Endpoints for course-related operations.
  static const course = _CourseEndpoints();
  static const studentCourse = _StudentCourseEndpoints();
}

/// Endpoints for authentication-related operations.
class _AuthEndpoints {
  const _AuthEndpoints();

  String get login => '${ApiUrl.baseUrl}/auth/student/login';
  String get register => '${ApiUrl.baseUrl}/auth/student/register';
  String get logout => '${ApiUrl.baseUrl}/auth/student/logout';
  String get forgetPassword => '${ApiUrl.baseUrl}/auth/student/forget-passord';
  String get verifyToken => '${ApiUrl.baseUrl}/auth/student/verify-token';
  String get resetPassword => '${ApiUrl.baseUrl}/auth/student/reset-password';
}

class _StudentCourseEndpoints {
  const _StudentCourseEndpoints();

  String get base => '${ApiUrl.baseUrl}/student/course';

  String get getCourses => base;
  String get getLastViewed => '$base/last-viewed';
  String get updateLastViewed => '$base/last-viewed';
  String getCourseDetails(int courseId) => '$base/class-room/$courseId';
  String getCertificate(int courseId) => '$base/certificate/$courseId';
}

class _CourseEndpoints {
  const _CourseEndpoints();

  String get base => '${ApiUrl.baseUrl}/course';

  String get getCourses => base;
  String get getCategories => '$base-category';
  String get getCourseDetails => '$base/details';
}
