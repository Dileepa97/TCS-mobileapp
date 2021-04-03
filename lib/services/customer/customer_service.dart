import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/customer/customer.dart';

import 'package:timecapturesystem/services/other/utils.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API'].toString();
var API = apiEndpoint + 'customers';
var apiAuth = DotEnv().env['API_Auth'].toString();
String contentTypeHeader = 'application/json';

class CustomerService {
  ///add new customer
  Future<dynamic> newCustomer(
      String orgId, String orgName, String orgEmail) async {
    try {
      var authHeader = await generateAuthHeader();

      var body = jsonEncode({
        "organizationID": orgId,
        "organizationName": orgName,
        "email": orgEmail
      });

      var res = await http.post(API, body: body, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 201) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///Get all customers
  Future<dynamic> getAllCustomers(dynamic context) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<Customer> _customerList =
            (resBody as List).map((i) => Customer.fromJson(i)).toList();

        return _customerList;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///delete customer
  Future<dynamic> deleteCustomer(String id) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.delete(API + '/$id', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        return res.statusCode;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///update customer
  Future<dynamic> updateCustomer(
      String id, String orgId, String orgName, String orgEmail) async {
    try {
      var authHeader = await generateAuthHeader();

      var body = jsonEncode({
        "organizationID": orgId,
        "organizationName": orgName,
        "email": orgEmail
      });

      var res = await http.put(API + '/$id', body: body, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }
}
