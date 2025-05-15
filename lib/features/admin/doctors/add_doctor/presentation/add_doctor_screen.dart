import 'package:command_care/features/admin/doctors/add_doctor/controllers/add_doctor_controller.dart';
import 'package:command_care/features/admin/doctors/controllers/doctors_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/constants/app_images.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/PrimaryButton.dart';
import 'package:command_care/core/widgets/PrimaryLottie.dart';
import 'package:command_care/core/widgets/PrimaryTextFormField.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/primary_app_bar.dart';
import 'package:command_care/features/auth/presentation/widgets/passwordField.dart';

class AddDoctorScreen extends ConsumerStatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends ConsumerState<AddDoctorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _specialisationController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final signUpController = ref.read(addDoctorControllerProvider.notifier);

    try {
      await signUpController.addDoctor(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phone: _phoneController.text.trim(),
        name: _nameController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: AppColors.successColor,
            content: Text('User added successfully')),
      );
      ref.refresh(doctorsProvider);
      _emailController.clear();
      _passwordController.clear();
      _phoneController.clear();
      _nameController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: AppColors.errorColor, content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(addDoctorControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      appBar: const PrimaryAppBar(title: 'Add Doctor'),
      body: BackgroundScreen(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const PrimaryLottie(
                  lottieAsset: AppLottie.loginAnimation,
                ),
                SizedBox(height: Dimensions.fontSizeDefault),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraLarge,
                  ),
                  child: PrimaryTextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    label: 'Phone',
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter a phone number'
                        : null,
                    prefixIcon: Icons.phone,
                  ),
                ),
                SizedBox(height: Dimensions.fontSizeDefault),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraLarge,
                  ),
                  child: PrimaryTextFormField(
                    controller: _nameController,
                    label: 'Name',
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter a name' : null,
                    prefixIcon: Icons.person_add_outlined,
                  ),
                ),
                SizedBox(height: Dimensions.fontSizeDefault),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraLarge,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _specialisationController.text.isNotEmpty
                        ? _specialisationController.text
                        : null,
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: TextStyle(color: AppColors.primaryTextColor),
                      fillColor: AppColors.whiteColor,
                      labelText: 'Specialisation',
                      prefixIcon: Icon(
                        Icons.code,
                        color: AppColors.nexusGreen,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    items: ['Physicians', 'Surgery', 'Radiology']
                        .map((specialisation) => DropdownMenuItem(
                              value: specialisation,
                              child: Text(specialisation),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _specialisationController.text = value;
                      }
                    },
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please select a specialisation'
                        : null,
                  ),
                ),
                SizedBox(height: Dimensions.fontSizeDefault),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraLarge,
                  ),
                  child: PrimaryTextFormField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,

                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter an email' : null,
                    prefixIcon: Icons.email,
                  ),
                ),
                SizedBox(height: Dimensions.fontSizeDefault),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraLarge,
                  ),
                  child: PasswordField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    onVisibilityToggle: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                SizedBox(height: Dimensions.fontSizeDefault),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraLarge,
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : PrimaryButton(
                          text: 'Add Doctor',
                          onPressed: _submit,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
