import 'dart:developer';
import 'dart:ffi';

import 'package:demo/model/applicants.dart';
import 'package:demo/model/dropdown_dto.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class Rest {
  final dio = Dio();

  Future<List<ApplicantDTO>?> getApplicantList() async {
    final response = await dio.get('http://10.0.2.2:8080/api/get');
    return ApplicantListDTO.fromJson(response.data).data;
  }

  Future<List<WorkSteps>?> fetchWorkingSteps() async {
    final response = await dio.get('http://10.0.2.2:8080/api/get-work-steps');
    return DropdownDTO.fromJson(response.data).data;
  }

  Future<List<WorkSteps>?> fetchBillingStatus() async {
    final response =
        await dio.get('http://10.0.2.2:8080/api/get-billing-status');
    return DropdownDTO.fromJson(response.data).data;
  }

  Future<bool> post(
      {int? id,
      String? workSteps,
      String? details,
      String? billingStatus,
      List<XFile>? files}) async {
    log("$workSteps");

    var formData = FormData.fromMap({
      "mstId": id,
      'workSteps': workSteps,
      'details': details,
      'billingStatus': billingStatus,
      'files': (files ?? []).isNotEmpty
          ? (files ?? [])
              .map((e) => MultipartFile.fromFileSync(e.path, filename: e.name))
              .toList()
          : []
    });
    var response = await dio.post('http://10.0.2.2:8080/api/update-status',
        data: formData);
    return true;
  }
}
