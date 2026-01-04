import 'package:animate_do/animate_do.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../../config/injection.dart';
import '../../../../core/widgets/futuristic_text_field.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/primary_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _countryController = TextEditingController();

  String _phoneNumber = '';
  // String _isoCode = 'NG'; // Removed unused variable
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) {
              context.go('/verify-email/${_emailController.text}');
            },
            error: (message) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Scaffold(
            body: Stack(
              children: [
                // Futuristic Background
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFE0F7FA), // Light Cyan
                        Color(0xFFE8F5E9), // Light Green
                        Color(0xFFF3E5F5), // Light Purple
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -100,
                  left: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orangeAccent.withValues(alpha: 0.2),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  right: -50,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xFF29844B).withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF29844B).withValues(alpha: 0.3),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),

                // Main Content
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          FadeInDown(
                            duration: const Duration(milliseconds: 800),
                            child: Hero(
                              tag: 'logo',
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          FadeInDown(
                            delay: const Duration(milliseconds: 200),
                            duration: const Duration(milliseconds: 800),
                            child: Text(
                              'Join Gonana',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          FadeInDown(
                            delay: const Duration(milliseconds: 400),
                            duration: const Duration(milliseconds: 800),
                            child: Text(
                              'Start your agricultural journey today.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Glass Form
                          GlassContainer(
                            opacity: 0.6,
                            blur: 15,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 500),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: FuturisticTextField(
                                            controller: _firstNameController,
                                            label: 'First Name',
                                            hint: 'John',
                                            validator: (v) =>
                                                v!.isEmpty ? 'Required' : null,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: FuturisticTextField(
                                            controller: _lastNameController,
                                            label: 'Last Name',
                                            hint: 'Doe',
                                            validator: (v) =>
                                                v!.isEmpty ? 'Required' : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Please use your official names as they appear on your Government ID for KYC verification.',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 11,
                                        color: Colors.orangeAccent[700],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 600),
                                    child: FuturisticTextField(
                                      controller: _emailController,
                                      label: 'Email',
                                      hint: 'john@example.com',
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Icons.email_outlined,
                                      validator: (v) =>
                                          v!.isEmpty || !v.contains('@')
                                          ? 'Valid email required'
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 700),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.5,
                                          ),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.05,
                                            ),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: InternationalPhoneNumberInput(
                                        onInputChanged: (PhoneNumber number) {
                                          _phoneNumber =
                                              number.phoneNumber ?? '';
                                        },
                                        selectorConfig: const SelectorConfig(
                                          selectorType: PhoneInputSelectorType
                                              .BOTTOM_SHEET,
                                          useEmoji: true,
                                        ),
                                        ignoreBlank: false,
                                        autoValidateMode:
                                            AutovalidateMode.disabled,
                                        selectorTextStyle:
                                            GoogleFonts.montserrat(
                                              color: Colors.black87,
                                            ),
                                        textStyle: GoogleFonts.montserrat(
                                          color: Colors.black87,
                                        ),
                                        initialValue: PhoneNumber(
                                          isoCode: 'NG',
                                        ),
                                        formatInput: true,
                                        inputDecoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Phone Number',
                                          hintStyle: GoogleFonts.montserrat(
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 800),
                                    child: InkWell(
                                      onTap: () {
                                        showCountryPicker(
                                          context: context,
                                          showPhoneCode: false,
                                          countryListTheme: CountryListThemeData(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            inputDecoration: InputDecoration(
                                              labelText: 'Search',
                                              hintText:
                                                  'Start typing to search',
                                              prefixIcon: const Icon(
                                                Icons.search,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color(
                                                    0xFF8C98A8,
                                                  ).withValues(alpha: 0.2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onSelect: (Country country) {
                                            setState(() {
                                              _countryController.text =
                                                  country.name;
                                            });
                                          },
                                        );
                                      },
                                      child: IgnorePointer(
                                        child: FuturisticTextField(
                                          controller: _countryController,
                                          label: 'Country',
                                          hint: 'Select Country',
                                          prefixIcon: Icons.public,
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          validator: (v) => v!.isEmpty
                                              ? 'Country required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 900),
                                    child: FuturisticTextField(
                                      controller: _passwordController,
                                      label: 'Password',
                                      hint: '******',
                                      obscureText: !_isPasswordVisible,
                                      prefixIcon: Icons.lock_outline,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey[600],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible =
                                                !_isPasswordVisible;
                                          });
                                        },
                                      ),
                                      validator: (v) =>
                                          v!.length < 6 ? 'Min 6 chars' : null,
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 1000),
                                    child: PrimaryButton(
                                      text: 'Sign Up',
                                      isLoading: isLoading,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (_phoneNumber.isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Please enter a valid phone number',
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          context.read<AuthBloc>().add(
                                            AuthEvent.signUpRequested(
                                              firstName:
                                                  _firstNameController.text,
                                              lastName:
                                                  _lastNameController.text,
                                              email: _emailController.text,
                                              phoneNumber: _phoneNumber,
                                              password:
                                                  _passwordController.text,
                                              country: _countryController.text,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Divider with "OR"
                          FadeInUp(
                            delay: const Duration(milliseconds: 1100),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey[700]
                                        : Colors.grey[300],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    'OR',
                                    style: GoogleFonts.montserrat(
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.grey[400]
                                          : Colors.grey[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey[700]
                                        : Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Google Sign-In Button
                          FadeInUp(
                            delay: const Duration(milliseconds: 1200),
                            child: OutlinedButton.icon(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  const AuthEvent.googleSignInRequested(),
                                );
                              },
                              icon: Image.asset(
                                'assets/images/google_icon.png',
                                width: 24,
                                height: 24,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.g_mobiledata, size: 24),
                              ),
                              label: Text(
                                'Continue with Google',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                side: BorderSide(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey[700]!
                                      : Colors.grey[300]!,
                                  width: 1.5,
                                ),
                                foregroundColor:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          FadeInUp(
                            delay: const Duration(milliseconds: 1300),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black54,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => context.pop(),
                                  child: Text(
                                    'Log In',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF29844B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
