import 'dart:async';
import 'dart:io';

import '../exceptions/app_exceptions.dart';
import 'base_service.dart';

class DetailsService extends BaseService {
  // only movie basic details
  Future<dynamic> getDetails(
      {required String resultType, required String id}) async {
    try {
      final response = await request(
          method: Requests.get,
          path: "/3/$resultType/$id",
          header: setHeaders(),
          queryParameter: setQueryParameters());

      // ignore: avoid_print
      // print('$resultType DETAILS STATUS => ${response.statusCode}');
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No hay Internet ');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Revisa si estas conectado al Internet');
    }
  }

// other movies details like (images,videos,credits,account_states,similar,recommendations,reviews,external_ids)
  Future<dynamic> getOtherDetails({
    required String resultType,
    required String id,
    required String appendTo,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/$resultType/$id/$appendTo",
        header: setHeaders(),
        queryParameter: setQueryParameters(),
      );

      //   // ignore: avoid_print
      //   print('$resultType OTHER DETAILS STATUS => ${value.statusCode}');
      //   print('$resultType RATED => ${jsonDecode(value.body)['rated']}');

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No hay Internet ');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Revisa si estas conectado al Internet');
    }
  }

// get collection details
  Future<dynamic> getCollectionDetails({required String collectionId}) async {
    try {
      await request(
        method: Requests.get,
        path: '/3/collection/$collectionId',
        queryParameter: setQueryParameters(),
      );

      return decodeResponse(response)['parts'];
    } on SocketException {
      throw FetchDataException('No hay conección al Internet');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Revisa si estas conectado al Internet');
    }
  }

  // rate movie/tv
  Future<dynamic> rate({
    required num value,
    required int? mediaId,
    required String mediaType,
  }) async {
    try {
      await request(
        method: Requests.post,
        path: '/3/$mediaType/$mediaId/rating',
        header: setHeaders(),
        queryParameter: setQueryParameters(),
        body: {"value": value},
      ).then((value) {
        print(value.statusCode);
      });

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conección al Internet');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Revisa si estas conectado al Internet');
    }
  }

  // rate movie/tv
  Future<dynamic> deleteRating({
    required int? mediaId,
    required String mediaType,
  }) async {
    try {
      await request(
        method: Requests.delete,
        path: '/3/$mediaType/$mediaId/rating',
        header: setHeaders(),
        queryParameter: setQueryParameters(),
      );

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conección al Internet');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Revisa si estas conectado al Internet');
    }
  }
}
