import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

import '../../common/constants/variables.dart';
import '../models/response/khs_response_model.dart';
import 'auth_local_datasorce.dart';

class KhsRemoteDatasource {
  Future<Either<String, KhsResponseModel>> getKhs() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${await AuthLocalDatasource().getToken()}'
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/khs'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(KhsResponseModel.fromJson(response.body));
    } else {
      return left('server error');
    }
  }
}
