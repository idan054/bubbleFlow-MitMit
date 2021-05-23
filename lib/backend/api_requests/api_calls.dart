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
