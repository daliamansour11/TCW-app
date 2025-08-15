import 'package:tcw/core/apis/api_response.dart';
import 'package:tcw/features/courses/data/models/category_model.dart';
import 'package:tcw/features/programmes/data/data_source/program_datasource_impl.dart';
import 'package:tcw/features/programmes/data/models/program_detail_model.dart';
import 'package:tcw/features/programmes/data/models/programme_model.dart';

abstract class ProgramRepository {
  Future<ApiResponse<List<ProgramModel>>> getPrograms({
    int limit,
    int offset,
    String? search,

  });

  Future<ApiResponse<ProgramDetailModel>> getProgramDetails(int courseId);

  Future<ApiResponse<List<CategoryModel>>> getCategories({
    int limit,
    int offset,
    bool subCategory,
  });
}

class ProgramRepositoryImpl implements ProgramRepository {
 const ProgramRepositoryImpl(this._datasource);
  final ProgramDatasource _datasource;


  @override
  Future<ApiResponse<List<ProgramModel>>> getPrograms({
    int limit = 10,
    int offset = 1,
    String? search,

  }) {
    return _datasource.getProgram(
      limit: limit,
      offset: offset,
      search: search,

    );
  }

  @override
  Future<ApiResponse<ProgramDetailModel>> getProgramDetails(int courseId) {
    return _datasource.getProgramDetails(courseId);
  }

  @override
  Future<ApiResponse<List<CategoryModel>>> getCategories({
    int limit = 10,
    int offset = 1,
    bool subCategory = false,
  }) {

      return _datasource.getCategories(limit: limit, offset: offset, subCategory: subCategory);

  }

}