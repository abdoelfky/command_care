import 'package:command_care/features/admin/patients/add_patient/controllers/add_patient_controller.dart';
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


class AddPatientScreen extends ConsumerStatefulWidget {
  const AddPatientScreen({super.key});

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends ConsumerState<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
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

    final signUpController = ref.read(addPatientControllerProvider.notifier);

    try {
      await signUpController.addUser(
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
    final isLoading = ref.watch(addPatientControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      appBar: const PrimaryAppBar(title: 'Add Patient'),
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
                  child: PrimaryTextFormField(
                    controller: _emailController,
                    label: 'Email',
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
                          text: 'Add Patient',
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
