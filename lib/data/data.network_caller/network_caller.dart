import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:task_manager_rafat/data/data.network_caller/network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url, {dynamic body}) async {
    try {
      log(url.toString());
      log(body.toString());
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {'content-type': 'Application/json'});

      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: 200,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString(),);

    }
  }
}
