import 'package:gagu_schedule/data/api/apiUtil.dart';
import 'package:gagu_schedule/data/api/service/servie_client.dart';

class ApiModule {
  static late ApiUtil _apiUtil;

  static ApiUtil apiUtil() {
    _apiUtil = ApiUtil(ServiceClient());
    return _apiUtil;
  }
}
