

import '../../core/constants/api_constants.dart';
import '../models/address_model.dart';
import '../services/api_service.dart';
import 'user_repository.dart';

class AddressRepository {
  final ApiService _api = ApiService();

  Future<AddressModel?> getAddress(String token) async {
    try {
      final res = await _api.get(
        endpoint: ApiConstants.getAddressEndpoint,
        // body: {},
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (res['data'] == null) return null;
      return AddressModel.fromJson(res['data']);

    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to add review: ${e.toString()}');
    }

  }

  Future<void> addAddress(AddressModel model, String token) async {

    try {
      await _api.post(
        endpoint: ApiConstants.addAddressEndpoint,
        body: model.toJson(),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to add review: ${e.toString()}');
    }

  }

  Future<void> updateAddress(AddressModel model, String token) async {
    try {
      print(model);
      await _api.put(
        endpoint: ApiConstants.updateAddressEndpoint,
        body: model.toJson(),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

    } on ApiException catch (e) {
      print('🔴 Repository: ApiException - ${e.message}');
      throw RepositoryException(e.message);
    } catch (e) {
      print('🔴 Repository: Unexpected error - $e');
      throw RepositoryException('Failed to add review: ${e.toString()}');
    }

  }
}
