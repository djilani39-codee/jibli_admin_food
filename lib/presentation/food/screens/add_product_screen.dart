import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jibli_admin_food/app/locator.dart';
import 'package:jibli_admin_food/app/theme.dart';
import 'package:jibli_admin_food/presentation/food/cubit/add_product_cubit.dart';
import 'package:jibli_admin_food/presentation/food/cubit/food_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  int? _selectedCategoryId;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm(BuildContext context) {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _selectedImage == null ||
        _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء جميع الحقول')),
      );
      return;
    }

    context.read<AddProductCubit>().addProduct(
          categoryId: _selectedCategoryId!,
          nameAr: _nameController.text,
          price: double.parse(_priceController.text),
          descriptionAr: _descriptionController.text,
          imagePath: _selectedImage!.path,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(sl()),
      child: BlocListener<AddProductCubit, AddProductState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (message, productId) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
              Navigator.pop(context, true);
            },
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.maybeWhen(
                    other: (message) => message,
                    orElse: () => 'حدث خطأ',
                  )),
                ),
              );
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('إضافة منتج جديد'),
          ),
          body: BlocBuilder<AddProductCubit, AddProductState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  children: [
                    // Image Picker
                    GestureDetector(
                      onTap: isLoading ? null : _pickImage,
                      child: Container(
                        height: 25.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.sp),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 50.sp,
                                      color: AppTheme.primaryColor,
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      'اختر صورة للمنتج',
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Category Dropdown (dynamic from FoodCubit)
                    BlocBuilder<FoodCubit, FoodState>(builder: (context, fState) {
                      final categories = fState.maybeWhen(
                        lastPageLoaded: (foods) => foods,
                        orElse: () => null,
                      );

                      final items = categories?.map<DropdownMenuItem<int>>((cat) {
                        return DropdownMenuItem<int>(
                          value: cat.categoryId,
                          child: Text(cat.categoryName ?? ''),
                        );
                      }).toList();

                      return DropdownButtonFormField<int>(
                        value: _selectedCategoryId,
                        hint: const Text('اختر الفئة'),
                        items: items,
                        onChanged: (isLoading || items == null)
                            ? null
                            : (value) {
                                setState(() {
                                  _selectedCategoryId = value;
                                });
                              },
                        decoration: InputDecoration(
                          labelText: 'الفئة',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 2.h),

                    // Name Field
                    TextField(
                      controller: _nameController,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        labelText: 'اسم المنتج',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Price Field
                    TextField(
                      controller: _priceController,
                      enabled: !isLoading,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: 'السعر',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Description Field
                    TextField(
                      controller: _descriptionController,
                      enabled: !isLoading,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'الوصف (اختياري)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),

                    // Submit Button
                    SizedBox(
                      width: 100.w,
                      height: 6.h,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () => _submitForm(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                        ),
                        child: isLoading
                            ? LoadingAnimationWidget.threeRotatingDots(
                                color: Colors.white,
                                size: 4.w,
                              )
                            : Text(
                                'إضافة المنتج',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
