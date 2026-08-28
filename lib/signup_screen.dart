import 'package:flutter/material.dart';
import 'package:letter/db.dart';
import 'package:letter/login.dart';
import 'package:letter/signup.dart';
import 'package:letter/styedButton.dart';
import 'package:letter/textStyle.dart';
import 'package:letter/theme.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Db sqlDB = Db();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
 String _selectedGender = "female";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _ageController.dispose();

    super.dispose();
    
  }

Future createProfile()async{

if(!_formKey.currentState!.validate())return;
List<Map>response=await sqlDB.read("PROFILE");
if (response.length >=5){
  if(!mounted)return;
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You have exceeded the allowed limit 5"),backgroundColor:Colors.redAccent ,));
return;
}
String name=_nameController.text.trim();
String email=_emailController.text.trim();
String password = _passwordController.text.trim();
    int age = int.parse(_ageController.text.trim());
    List<Map>checkname=await sqlDB.getNotesProfile("PROFILE", "profilename='$name'");
    if (checkname.isNotEmpty){
      if(!mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The account name is already in use, choose another name"),backgroundColor:Colors.redAccent ,));
return;
    }
    int insert= await sqlDB.insert("PROFILE", {
      "profilename": name,
      "profileemail":email,
      "password": password,
      "age": age,
      "gender": _selectedGender,
    });

    if(insert>0){
      print("ok");
      if(!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account created successfully! Please login"),backgroundColor:Colors.redAccent ,));
Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Login()),

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
              Styleheading('welcome'),
              const SizedBox(height: 10),

              _buildTextField(
                controller: _nameController,
                hint: 'Full Name',
                icon: Icons.email_outlined,
                validator:(value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(value)) {
                    return 'Letters only allowed';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
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
                            const SizedBox(height: 15),

_buildTextField(
                controller: _ageController,
                hint: 'Age',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your age';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Numbers only allowed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Gender:",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Radio<String>(
                    value: "female",
                    groupValue: _selectedGender,
                    activeColor: AppColors.primaryAccent,
                    onChanged: (value) => setState(() => _selectedGender = value!),
                  ),
                  const Text("Female", style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 10),
                  Radio<String>(
                    value: "male",
                    groupValue: _selectedGender,
                    activeColor: AppColors.primaryAccent,
                    onChanged: (value) => setState(() => _selectedGender = value!),
                  ),
                  const Text("Male", style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 30),

              StyledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                   createProfile();
                  }
                },
                child: const Stylebody('Signup'),
              ),

              const SizedBox(height: 30),


              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Do you have an account? ",
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    children: [
                      TextSpan(
                        text: 'Sign in',
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
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
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