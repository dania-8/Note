import 'package:flutter/material.dart';
import 'package:letter/db.dart';
import 'package:letter/home.dart';
import 'package:letter/signup.dart';
import 'package:letter/styedButton.dart';
import 'package:letter/textStyle.dart';
import 'package:letter/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

   Db sqlDB=Db();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
Future checkLogin() async{
  if(!_formKey.currentState!.validate())return;
  String email=_emailController.text.trim();
    String password=_passwordController.text.trim();

  List<Map> response=await sqlDB.getNotesProfile("PROFILE", "profileemail='$email' AND password='$password'");

  if(!mounted) return;

  if(response.isNotEmpty){
int profileId = response.first['profileid'];
Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Home(currentProfileId: profileId),
        ),
      );
  }
  else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incorrect account Email or password"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secndryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Styletitle('NOTES'),
              const SizedBox(height: 50),
              Styleheading('welcome Back!'),
              const SizedBox(height: 10),

              _buildTextField(
                controller: _emailController,
                hint: 'Email',
                icon: Icons.email_outlined,
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter your Email' : null,
              ),

              const SizedBox(height: 20),

              _buildTextField(
                controller: _passwordController,
                hint: 'password',
                icon: Icons.lock_outline_rounded,
                obscure: true,
                validator: (value) => (value == null || value.length < 6) ? 'it should be at least 6 characters' : null,
              ),

              const SizedBox(height: 30),

              StyledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) 
                  {
                    checkLogin();
                  }
                },
                child: const Stylebody('login'),
              ),

              const SizedBox(height: 30),

              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Signup()),
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    children: [
                      TextSpan(
                        text: 'create now',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primaryAccent),
        filled: true,
        fillColor: AppColors.secndryColor,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.secndryColor, width: 2),
        ),
      ),
      validator: validator,
    );
  }
}