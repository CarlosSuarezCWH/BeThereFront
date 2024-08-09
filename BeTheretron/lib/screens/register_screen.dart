import 'package:flutter/material.dart';
import 'package:betherapp/services/register_service.dart';
import 'package:betherapp/widgets/input_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final RegisterService _registerService = RegisterService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  Future<void> _register() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final dateOfBirth = _selectedDate != null
        ? '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}'
        : '';

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        dateOfBirth.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _registerService.register(name, email, password, dateOfBirth);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
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
          _buildRegistrationForm(size, context),
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
      child: const Icon(Icons.person_add, color: Colors.white, size: 80),
    );
  }

  Widget _buildRegistrationForm(Size size, BuildContext context) {
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
                'Register',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create a new account.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              InputField(
                controller: _nameController,
                labelText: 'Name',
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
              _buildDateOfBirthField(),
              const SizedBox(height: 20),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateOfBirthField() {
    return TextField(
      controller: TextEditingController(
        text: _selectedDate != null
            ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
            : 'Select Date of Birth',
      ),
      decoration: const InputDecoration(
        labelText: 'Date of Birth',
        labelStyle: TextStyle(
          fontSize: 12,
          color: Color(0xFF8F8E8E),
        ),
        contentPadding: EdgeInsets.only(top: 5, left: 10),
        filled: true,
        fillColor: Color(0xFFF5F5F5),
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null && pickedDate != _selectedDate) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _register,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Register'),
      ),
    );
  }
}
