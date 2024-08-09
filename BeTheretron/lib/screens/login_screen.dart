import 'package:flutter/material.dart';
import 'package:betherapp/services/auth_service.dart';
import 'package:betherapp/screens/register_screen.dart';
import 'package:betherapp/screens/forgotpass_screen.dart';
import 'package:betherapp/widgets/input_field.dart';
import 'package:betherapp/widgets/menu_section.dart'; // Importa MenuSection

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (!_validateFields(email, password)) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final error = await _authService.login(email, password);

      if (error != null) {
        setState(() {
          _errorMessage = error;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const MenuSection()), // Cambiar a MenuSection
        );
      }
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

  bool _validateFields(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor complete todos los campos';
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    _buildIcon(constraints),
                    Expanded(child: _buildLoginForm(context, constraints)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Center(
      child: SizedBox.expand(
        child: Image.asset(
          'assets/images/4.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildIcon(BoxConstraints constraints) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: constraints.maxWidth * 0.3,
      height: constraints.maxWidth * 0.3,
      child: const Icon(Icons.person_pin, color: Colors.white, size: 100),
    );
  }

  Widget _buildLoginForm(BuildContext context, BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(constraints.maxWidth * 0.3),
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height - constraints.maxWidth * 0.3,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue.',
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
              InputField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 10),
              ],
              _buildLoginButton(),
              const SizedBox(height: 20),
              _buildFooterButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Text('Login'),
      ),
    );
  }

  Widget _buildFooterButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen(),
              ),
            );
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Color(0xFF1C2120)),
          ),
        ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegistrationScreen(),
              ),
            );
          },
          child: const Text(
            'Signup!',
            style: TextStyle(color: Color(0xFF1C2120)),
          ),
        ),
      ],
    );
  }
}
