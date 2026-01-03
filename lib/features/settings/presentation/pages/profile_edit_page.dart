import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import 'package:go_router/go_router.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Added form key
  bool _isDataLoaded = false; // Flag to prevent overwriting user edits

  @override
  void initState() {
    super.initState();
    // Trigger initial load if not already loaded
    // But typically the Page should be opened with data already or Bloc should have it.
    // We can rely on BlocBuilder to populate.
    _loadInitialData();
  }

  void _loadInitialData() {
    final state = context.read<SettingsBloc>().state;
    state.maybeWhen(
      loaded: (user) {
        _populateFields(user);
      },
      orElse: () {
        // If not loaded, maybe trigger fetch?
        // context.read<SettingsBloc>().add(const SettingsEvent.started());
        // For now, assume data might be there or coming.
      },
    );
  }

  void _populateFields(dynamic user) {
    if (_isDataLoaded)
      return; // Don't verify if already loaded once to preserve edits?
    // Actually, if we want to allow reset, we can separate logic.
    // For init, we want to set it once.
    if (_fullNameController.text.isEmpty) {
      _fullNameController.text = "${user.firstName} ${user.lastName}";
    }
    if (_usernameController.text.isEmpty) {
      _usernameController.text = user.username ?? "";
    }
    if (_bioController.text.isEmpty) {
      _bioController.text = user.bio ?? "";
    }
    _isDataLoaded = true;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (user) {
            // If data just loaded and we haven't typed yet, populate?
            // Or if we just saved successfully.
            if (!_isDataLoaded) {
              _populateFields(user);
            }
          },
          error: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $msg'),
                backgroundColor: Colors.red,
              ),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        // If we want to show success message and close AFTER save
        // The listener is better for that.
        // We handle 'saved' logic there?
        // Current Bloc emits 'loaded' after update.
        // So we can detect that transition if strictly needed, but simple listener is okay.

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              'Edit Profile',
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
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: Theme.of(context).brightness == Brightness.dark
                        ? [
                            const Color(0xFF1E1E1E),
                            const Color(0xFF2C2C2C),
                            const Color(0xFF000000),
                          ]
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
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: 120, // Slightly larger
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: AppTheme.primaryColor,
                                      width: 3,
                                    ),
                                    image: _imageFile != null
                                        ? DecorationImage(
                                            image: FileImage(_imageFile!),
                                            fit: BoxFit.cover,
                                          )
                                        : state.maybeWhen(
                                            loaded: (user) =>
                                                user.profilePhoto != null
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                      user.profilePhoto!,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )
                                                : null,
                                            orElse: () => null,
                                          ),
                                  ),
                                  child:
                                      _imageFile == null &&
                                          state.maybeWhen(
                                            loaded: (user) =>
                                                user.profilePhoto == null,
                                            orElse: () => true,
                                          )
                                      ? const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey,
                                        )
                                      : null,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildTextField(
                          context,
                          'Full Name',
                          _fullNameController,
                          validator: (v) =>
                              v!.isEmpty ? 'Name is required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          context,
                          'Username',
                          _usernameController,
                          validator: (v) =>
                              v!.isEmpty ? 'Username is required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          context,
                          'Bio',
                          _bioController,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 48),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state.maybeMap(
                              loading: (_) => null,
                              orElse: () => _saveProfile,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                            child: state.maybeWhen(
                              loading: () => const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              orElse: () => Text(
                                'Save Changes',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final names = _fullNameController.text.trim().split(' ');
      final String firstName = names.isNotEmpty ? names.first : "";
      final String lastName = names.length > 1
          ? names.sublist(1).join(' ')
          : "";

      // Trigger Update
      context.read<SettingsBloc>().add(
        SettingsEvent.updateProfile(
          firstName: firstName,
          lastName: lastName,
          profilePhoto: _imageFile,
          bio: _bioController.text,
          username: _usernameController.text,
        ),
      );

      // Listen for success in BlocListener to pop
    }
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    TextEditingController controller, {
    bool enabled = true,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        GlassContainer(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 2,
          ), // Adjusted padding
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.7),
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            maxLines: maxLines,
            validator: validator,
            style: GoogleFonts.outfit(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[400]
                    : Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
