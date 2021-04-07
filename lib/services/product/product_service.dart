import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timecapturesystem/models/product/product.dart';
import 'package:timecapturesystem/services/other/utils.dart';
import 'package:http/http.dart' as http;

var apiEndpoint = DotEnv().env['API'].toString();
var API = apiEndpoint + 'products';
var apiAuth = DotEnv().env['API_Auth'].toString();
String contentTypeHeader = 'application/json';

class ProductService {
  ///add new product
  Future<dynamic> newProduct(
      String productName, String description, List<String> custIdList) async {
    try {
      var authHeader = await generateAuthHeader();

      var body = jsonEncode({
        "productName": productName,
        "productDescription": description,
        "customerIdList": custIdList
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

  ///Get all products
  Future<dynamic> getAllProducts(dynamic context) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API, headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        List<Product> _productList =
            (resBody as List).map((i) => Product.fromJson(i)).toList();

        _productList.sort((a, b) => a.productName.compareTo(b.productName));

        return _productList;
      } else if (res.statusCode == 204) {
        return res.statusCode;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///get product by id
  static Future<dynamic> getProductById(String id) async {
    try {
      var authHeader = await generateAuthHeader();

      var res = await http.get(API + '/$id', headers: {
        HttpHeaders.authorizationHeader: authHeader,
        HttpHeaders.contentTypeHeader: contentTypeHeader
      });

      if (res.statusCode == 200) {
        var resBody = json.decode(res.body);

        Product _customer = Product.fromJson(resBody);

        return _customer;
      } else {
        return 1;
      }
    } catch (e) {
      return -1;
    }
  }

  ///delete product
  Future<dynamic> deleteProduct(String id) async {
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

  ///update product
  Future<dynamic> updateProduct(String id, String productName,
      String description, List<String> custIdList) async {
    try {
      var authHeader = await generateAuthHeader();

      var body = jsonEncode({
        "productName": productName,
        "productDescription": description,
        "customerIdList": custIdList
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
