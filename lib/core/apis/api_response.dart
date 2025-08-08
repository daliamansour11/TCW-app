class ApiResponse<T> {
  ApiResponse({
    this.data,
    required this.mapData,
    this.message,
    required this.statusCode,
    this.lastPage,
    this.limit,
    this.offset,
    this.total,
  });

  final T? data;
  final Map<String, dynamic> mapData; // Fixed type to Map<String, dynamic>
  final int statusCode;
  final String? message;
  final int? limit;
  final int? offset;
  final int? total;
  final int? lastPage;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
  bool get isError => !isSuccess;

  // Create error response with proper typing
  ApiResponse<TNew> error<TNew>({String? message}) {
    return ApiResponse<TNew>(
      message: message ?? this.message,
      mapData: this.mapData,
      data: null,
      statusCode: this.statusCode,
      lastPage: this.lastPage,
      limit: this.limit,
      offset: this.offset,
      total: this.total,
    );
  }

  // Type-safe copyWith method
  ApiResponse<TNew> copyWith<TNew>({
    TNew? data,
    int? statusCode,
    Map<String, dynamic>? mapData, // Fixed type
    String? message,
    int? limit,
    int? offset,
    int? total,
    int? lastPage,
  }) {
    return ApiResponse<TNew>(
      data: data ?? (this.data as TNew?),
      statusCode: statusCode ?? this.statusCode,
      mapData: mapData ?? this.mapData,
      message: message ?? this.message,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      total: total ?? this.total,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  String toString() {
    return '''
ApiResponse:
  message: $message
  mapData: $mapData
  data: $data
  statusCode: $statusCode
  isSuccess: $isSuccess
  isError: $isError
  pagination: (limit: $limit, offset: $offset, total: $total, lastPage: $lastPage)
''';
  }
}