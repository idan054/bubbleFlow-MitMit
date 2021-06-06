import 'api_manager.dart';

Future<dynamic> randomUserDataCall({
  String uid = '',
}) =>
    ApiManager.instance.makeApiCall(
      callName: 'Random user Data',
      apiDomain: 'random-data-api.com',
      apiEndpoint: 'api/users/random_user',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'uid': uid,
      },
      returnResponse: true,
    );

Future<dynamic> fireBaseGetCall({
  String collectionPath = '',
}) =>
    ApiManager.instance.makeApiCall(
      callName: 'FireBase Get',
      apiDomain: 'us-central1-bubbleflow-mitmit.cloudfunctions.net',
      apiEndpoint: 'GetPost_Collections?$collectionPath',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnResponse: true,
    );
