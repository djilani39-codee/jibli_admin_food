import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';
import 'package:jibli_admin_food/core/bloc/error.dart';
import 'package:jibli_admin_food/domain/repository/food_repository.dart';
import 'package:jibli_admin_food/app/locator.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_keys.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/domain/entity/fast_food_entity/fast_food_response.dart';

part 'add_product_state.dart';
part 'add_product_cubit.freezed.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.foodRepository) : super(const AddProductState.initial());
  
  final FoodRepository foodRepository;

  Future<void> addProduct({
    required int categoryId,
    required String nameAr,
    required double price,
    String? descriptionAr,
    required String imagePath,
  }) async {
    try {
      emit(const AddProductState.loading());

      final imageFile = await MultipartFile.fromFile(
        imagePath,
        filename: 'product.jpg',
      );

      print('📁 Image file info:');
      print('   - Path: $imagePath');
      print('   - Filename: ${imageFile.filename}');

      // gather auth values from local storage
      final FastFoodEntity? user = sl<LocalDataSource>().getValue(LocalDataKeys.user);
      final String? marketId = user?.markets?.first.marketId;
      final int? userId = user?.userId;
      final String? apiToken = user?.apiToken;

      final Map<String, dynamic> payload = {
        if (userId != null) 'user_id': userId.toString(),
        if (marketId != null) 'market_id': marketId,
        if (apiToken != null) 'api_token': apiToken,
        'category_id': categoryId.toString(),
        'name_ar': nameAr,
        'price': price.toString(),
        if (descriptionAr != null && descriptionAr.isNotEmpty) 'description_ar': descriptionAr,
        'image': imageFile,
      };

      final formData = FormData.fromMap(payload);

      print('📦 FormData payload keys: ${payload.keys}');

      final result = await foodRepository.addNewProduct(formData);

      result.when(
        success: (data) {
          print('✅ Product added successfully');
          print('📊 Response data: ${data?.data?.length} categories');
          print('📦 Full response: $data');
          emit(AddProductState.success(
            message: 'تم إضافة المنتج بنجاح',
            productId: null,
          ));
        },
        failure: (error) {
          final errorMsg = error?.maybeWhen(
                network: (message) => 'خطأ شبكة: $message',
                wrongCredentials: (data) => 'بيانات غير صحيحة: ${data?.toString()}',
                orElse: () => 'حدث خطأ غير معروف',
              ) ?? 'خطأ غير متوقع';
          print('❌ Error adding product: $errorMsg');
          print('📛 Full error: $error');
          emit(
            AddProductState.error(
              error?.maybeWhen(
                    network: (message) => ErrorState.networkError(message: message ?? ''),
                    wrongCredentials: (data) => const ErrorState.unAuthrized(),
                    orElse: () => const ErrorState.other(message: 'حدث خطأ'),
                  ) ??
                  const ErrorState.other(message: 'حدث خطأ غير معروف'),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        AddProductState.error(
          ErrorState.other(message: e.toString()),
        ),
      );
    }
  }
}
