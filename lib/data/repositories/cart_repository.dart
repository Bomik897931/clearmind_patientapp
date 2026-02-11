
import 'package:Clarminds/data/repositories/user_repository.dart';

import '../../core/constants/api_constants.dart';
import '../models/cart_response_model.dart';
import '../models/prescription_model.dart';
import '../services/api_service.dart';

class CartRepository {
  final ApiService _apiService = ApiService();

  Future<PrescriptionListResponse> getMyPrescriptions({
    required String token,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      print(
          '🔵 Repository: Fetching prescriptions (Page: $pageNumber, Size: $pageSize)');

      final response = await _apiService.getRaw(
        endpoint: '${ApiConstants
            .myPrescriptionsEndpoint}?PageNumber=$pageNumber&PageSize=$pageSize',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('🟢 Repository: Response: $response');
      print('RuntimeType: ${response.runtimeType}');

      Map<String, dynamic> responseData;

      if (response is Map<String, dynamic>) {
        if (response['success'] == true &&
            response['data'] is Map<String, dynamic>) {
          responseData = response['data'];
        } else if (response['data'] is Map<String, dynamic>) {
          responseData = response['data'];
        } else {
          throw RepositoryException(
            response['message'] ??
                'Expected "data" key containing Map<String, dynamic>',
          );
        }
      } else {
        throw RepositoryException('Invalid response format');
      }

      final prescriptionList = PrescriptionListResponse.fromJson(responseData);
      print('✅ Repository: Loaded ${prescriptionList.items
          .length} prescriptions');
      return prescriptionList;
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException(
          'Failed to fetch prescriptions: ${e.toString()}');
    }
  }

  /// GET CART DETAILS
  Future<CartResponse> getCart({
    required int prescriptionId,
    required String token,
  }) async {
    try {
      print('${ApiConstants
          .myPrescriptionsCartByIdEndpoint}/$prescriptionId');
      final response = await _apiService.get(
        endpoint: '${ApiConstants
            .myPrescriptionsCartByIdEndpoint}/$prescriptionId',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      return CartResponse.fromJson(response['data']);
    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to add review: ${e.toString()}');
    }
  }

  Future<CartResponse> getMyCartDetail({
    required String token,
  }) async {
    print('🟡 API CALL → my-cart-detail');

    final response = await _apiService.get(
      endpoint: ApiConstants.myCartDetailsEndpoint,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('🟢 RAW API RESPONSE TYPE: ${response.runtimeType}');
    print('🟢 RAW API RESPONSE: $response');

    if (response is Map<String, dynamic>) {
      if (response.containsKey('data')) {
        print('🟢 Parsing response["data"]');
        return CartResponse.fromJson(response['data']);
      } else {
        print('🟢 Parsing response directly');
        return CartResponse.fromJson(response);
      }
    } else {
      print('🔴 Invalid response format');
      throw Exception('Invalid cart response');
    }
  }

}
