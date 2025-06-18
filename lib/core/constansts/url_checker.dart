class UrlChecker {

  static final _urlCheckReg = RegExp(r"((http|https)://)(www.)?" "[a-zA-Z0-9@:%._\\+~#?&//=]" "{2,256}\\.[a-z]" "{2,6}\\b([-a-zA-Z0-9@:%" "._\\+~#?&//=]*)");

  static final _checkImageUrlReg = RegExp(r"(https?:\/\/.*\.(?:jpg|jpeg|png|webp|avif|gif|svg))");

  static bool isImageUrl(String url) {
    return _checkImageUrlReg.hasMatch(url);
  }

  static bool isValid(String url) {
    return _urlCheckReg.hasMatch(url);
  }
}