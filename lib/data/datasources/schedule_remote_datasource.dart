// ignore_for_file: file_names

import 'dart:convert';

// import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/variables.dart';
import '../models/response/schedule_response_model.dart';
import 'auth_local_datasorce.dart';

class ScheduleRemoteDatasource {
  Future<List<ScheduleResponseModel>> getSchedules() async {
    try {
      final header = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': 'Bearer ${await AuthLocalDatasource().getToken()}',
      };
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/schedules'),
        headers: header,
      );

      print('Raw JSON Response: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<ScheduleResponseModel> schedules = jsonResponse
            .map((data) => ScheduleResponseModel.fromMap(data))
            .toList();

        return schedules;
      } else {
        throw Exception('Failed to load schedules');
      }
    } catch (e) {
      print('Error in getSchedules: $e');
      throw Exception('An error occurred');
    }
  }
}
