import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/customer/customer.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API'].toString();
String endPointName = 'customers';
// ignore: non_constant_identifier_names
var API = apiEndpoint + endPointName;
var apiAuth = apiEndpoint.toString().split('/').elementAt(2);

String contentTypeHeader = 'application/json';

class CustomerService {
  ///add new customer - admin
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

        _customerList
            .sort((a, b) => a.organizationName.compareTo(b.organizationName));

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

  ///get customer by id
  static Future<dynamic> getCustomerById(String id) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API + '/$id', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        Customer _customer = Customer.fromJson(resBody);

        return _customer;
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
