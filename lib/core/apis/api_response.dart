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
  final Map mapData;
  final int statusCode;
  final String? message;
  final int? limit, offset, total, lastPage;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  bool get isError =>
       statusCode < 200 || statusCode >= 300;
  // error ApiResponse
  ApiResponse<TNew> error<TNew>() {
    return ApiResponse<TNew>(
      message: this.message,
      mapData: this.mapData,
      data: null,
      statusCode: this.statusCode,
    );
  }

  ApiResponse<TNew> copyWith<TNew>({
    TNew? data,
    int? statusCode,
    Map? mapData,
    String? message,
    int? limit,
    int? offset,
    int? total,
    int? lastPage,
  }) {
    return ApiResponse<TNew>(
      lastPage: lastPage ?? this.lastPage,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      total: total ?? this.total,
      message: message ?? this.message,
      mapData: mapData ?? this.mapData,
      data: data,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  String toString() {
    return 'message:$message\n mapData:$mapData\n data:$data\n,statusCode:$statusCode,isSuccess:$isSuccess,isError:$isError';
  }
}
