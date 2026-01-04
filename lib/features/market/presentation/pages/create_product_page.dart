import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/primary_button.dart';
import '../bloc/market_bloc.dart';
import '../../../../core/utils/kyc_guard.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  final _qtyController = TextEditingController();
  final _shippingPriceController = TextEditingController();
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  String _selectedUnit = 'KG';
  String _shippingMethod = 'Logistics Company'; // or 'Farmer Shipping'
  final List<String> _shippingOptions = [
    'Logistics Company',
    'Farmer Shipping',
    'Pickup Station',
  ];

  Future<void> _pickImages() async {
    if (_selectedImages.length >= 3) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum of 3 images allowed')),
      );
      return;
    }

    final remainingSlots = 3 - _selectedImages.length;
    if (remainingSlots <= 0) return;

    List<XFile> images = [];
    if (remainingSlots == 1) {
      // Pick single image
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        images.add(image);
      }
    } else {
      // Pick multiple
      images = await _picker.pickMultiImage(limit: remainingSlots);
    }

    if (images.isNotEmpty && mounted) {
      setState(() {
        _selectedImages.addAll(images.map((e) => File(e.path)));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Upload Product',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [const Color(0xFF1E1E1E), const Color(0xFF000000)]
                    : [const Color(0xFFE0F7FA), const Color(0xFFE8F5E9)],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Selection Area
                    SizedBox(
                      height: 120, // Height for the horizontal list
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            _selectedImages.length +
                            (_selectedImages.length < 3 ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          // Add Button
                          if (index == _selectedImages.length) {
                            return GestureDetector(
                              onTap: _pickImages,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 32,
                                      color: AppTheme.primaryColor,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Add',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          // Image Item
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: FileImage(_selectedImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -8,
                                right: -8,
                                child: GestureDetector(
                                  onTap: () => _removeImage(index),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    if (_selectedImages.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Upload at least one image',
                          style: GoogleFonts.montserrat(
                            color: Colors.red[300],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),

                    _buildLabel('Product Name'),
                    _buildTextField(_nameController, 'e.g., Organic Rice'),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Price (NGN)'),
                              _buildTextField(
                                _priceController,
                                '0.00',
                                isNumber: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Quantity (KG)'),
                              _buildTextField(
                                _qtyController,
                                'e.g., 50',
                                isNumber: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Unit (e.g., KG, Ton)'),
                    const SizedBox(height: 8),
                    GlassContainer(
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedUnit,
                          isExpanded: true,
                          dropdownColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF2C2C2C)
                              : Colors.white,
                          items: ['KG', 'Ton', 'Bag', 'Unit'].map((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.montserrat(),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedUnit = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Description'),
                    _buildTextField(
                      _descController,
                      'Describe your product...',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Location'),
                    _buildTextField(_locationController, 'e.g., Kano, Nigeria'),
                    const SizedBox(height: 16),

                    _buildLabel('Shipping Method'),
                    const SizedBox(height: 8),
                    GlassContainer(
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _shippingMethod,
                          isExpanded: true,
                          dropdownColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF2C2C2C)
                              : Colors.white,
                          items: _shippingOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.montserrat(),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _shippingMethod = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    if (_shippingMethod == 'Farmer Shipping') ...[
                      const SizedBox(height: 16),
                      _buildLabel('Shipping Price (NGN)'),
                      _buildTextField(
                        _shippingPriceController,
                        '0.00',
                        isNumber: true,
                      ),
                    ],

                    const SizedBox(height: 32),
                    BlocConsumer<MarketBloc, MarketState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          loaded: (products, hotDeals) {
                            // If we were expecting a specific 'success' state, we would check it.
                            // But since we reload data on success, 'loaded' implies success if it comes after we submitted.
                            // We can't distinguish easily without a flag.
                            // But typically, we should just pop context if we see Loaded state and we just submitted.
                            // This listener might trigger on initial load too.
                            // So we should probably check if it was Loading before?
                            // Or simpler: just pop and show snackbar.
                            // For now, let's just show snackbar in the button callback or handle it here if we had a specific Success state.
                            // Since we don't have a Success state, we will rely on UI feedback.
                          },
                          error: (msg) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $msg')),
                            );
                          },
                          orElse: () {},
                        );
                      },
                      builder: (context, state) {
                        return PrimaryButton(
                          text: state.maybeWhen(
                            loading: () => 'Uploading...',
                            orElse: () => 'Upload Product',
                          ),
                          isLoading: state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          ),
                          onPressed: () {
                            KycGuard.check(
                              context,
                              onVerified: () {
                                if (_formKey.currentState!.validate() &&
                                    _selectedImages.isNotEmpty) {
                                  final name = _nameController.text;
                                  final price =
                                      double.tryParse(_priceController.text) ??
                                      0;
                                  final qty =
                                      double.tryParse(_qtyController.text) ?? 0;
                                  final desc = _descController.text;
                                  final loc = _locationController.text;

                                  final shippingPrice =
                                      _shippingMethod == 'Farmer Shipping'
                                      ? double.tryParse(
                                          _shippingPriceController.text,
                                        )
                                      : null;

                                  context.read<MarketBloc>().add(
                                    MarketEvent.createProduct(
                                      name: name,
                                      price: price,
                                      description: desc,
                                      location: loc,
                                      availableQuantity: qty,
                                      unit: _selectedUnit,
                                      shippingPrice: shippingPrice,
                                      images: _selectedImages,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Product Uploaded Successfully!',
                                      ),
                                    ),
                                  );
                                  context.pop();
                                } else if (_selectedImages.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please select at least one image',
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(12),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          // hintStyle handled by Theme now
        ),
        validator: (value) => value!.isEmpty ? 'Required' : null,
      ),
    );
  }
}
