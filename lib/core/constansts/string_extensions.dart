extension StringExtensions on String {
  String capitalizeLikeCamelCase() {
    try {
      return split(' ')
          .map((str) => str[0].toUpperCase() + str.substring(1))
          .join(' ');
    } catch (e) {
      return this;
    }
  }
  // Date
  
}

extension StringSafetyExtensions on String? {
  //
  int? get toIntOrNull {
    if (this == null || this!.isEmpty) {
      return null;
    }
    return int.tryParse(this!);
  }
  
}
