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

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController _fullNameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    // In a real app, populate from BLoC state or passed arguments
    _fullNameController = TextEditingController(text: "Gonana User");
    _usernameController = TextEditingController(text: "gonana_user");
    _bioController = TextEditingController(text: "Crypto enthusiast");

    // Attempt to pre-fill if BLoC has data
    final state = context.read<SettingsBloc>().state;
    state.maybeWhen(
      loaded: (user) {
        _fullNameController.text = "${user.firstName} ${user.lastName}";
        // _usernameController.text = user.username ?? "";
        _bioController.text = user.bio ?? "";
      },
      orElse: () {},
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
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
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                              border: Border.all(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                              image: _imageFile != null
                                  ? DecorationImage(
                                      image: FileImage(_imageFile!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _imageFile == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
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
                              padding: const EdgeInsets.all(4),
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
                  const SizedBox(height: 24),
                  _buildTextField(context, 'Full Name', _fullNameController),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Username', _usernameController),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Bio', _bioController),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<SettingsBloc, SettingsState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          loaded: (_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profile updated successfully!'),
                              ),
                            );
                            Navigator.pop(context);
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
                        return ElevatedButton(
                          onPressed: state.maybeWhen(
                            loading: () => null,
                            orElse: () => () {
                              final names = _fullNameController.text.split(' ');
                              String firstName = names.isNotEmpty
                                  ? names.first
                                  : "";
                              String lastName = names.length > 1
                                  ? names.sublist(1).join(' ')
                                  : "";

                              context.read<SettingsBloc>().add(
                                SettingsEvent.updateProfile(
                                  firstName: firstName,
                                  lastName: lastName,
                                  profilePhoto: _imageFile,
                                  bio: _bioController.text,
                                ),
                              );
                            },
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: state.maybeWhen(
                            loading: () => const CircularProgressIndicator(
                              color: Colors.white,
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    TextEditingController controller, {
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        GlassContainer(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(12),
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ),
      ],
    );
  }
}
