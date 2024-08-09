import 'package:flutter/material.dart';
import 'package:betherapp/services/forgot_password_service.dart';
import 'package:betherapp/widgets/input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordService _forgotPasswordService = ForgotPasswordService();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  Future<void> _submit() async {
    final email = _emailController.text;

    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor ingrese su correo electrónico';
        _successMessage = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      await _forgotPasswordService.sendPasswordResetEmail(email);
      setState(() {
        _successMessage = 'Correo de restablecimiento enviado';
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Error: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                _buildIcon(size),
              ],
            ),
          ),
          _buildForgotPasswordForm(size, context),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla de login
          },
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(32, 36, 40, 1),
            Color.fromRGBO(17, 19, 21, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildIcon(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: size.height * 0.20,
      child: const Icon(Icons.lock_open, color: Colors.white, size: 80),
    );
  }

  Widget _buildForgotPasswordForm(Size size, BuildContext context) {
    return Positioned(
      top: size.height * 0.25,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(110),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your email to receive password reset instructions.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              InputField(
                controller: _emailController,
                labelText: 'Email',
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 10),
              ],
              if (_successMessage != null) ...[
                Text(
                  _successMessage!,
                  style: const TextStyle(color: Colors.green),
                ),
                const SizedBox(height: 10),
              ],
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submit,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Submit'),
      ),
    );
  }
}
