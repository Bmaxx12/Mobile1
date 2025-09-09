import 'package:excerciseflut/home_screen.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page', style: TextStyles.title),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/ui_login.png'),
              const SizedBox(height: 24.0),
              Text(
                'Login Details',
                style: TextStyles.title.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 24.0),
              CustomTextfield(
                controller: userController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                hint: 'username',
              ),
              const SizedBox(height: 10.0),
              CustomTextfield(
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                hint: 'password',
                isObscure: isObscure,
                hasSuffix: true,
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    String msg = "";
                    bool isLogin = false;
                    if (userController.text == '123' && passwordController.text == '123') {
                      msg = "Login Berhasil";
                      isLogin = true;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      msg = "Login gagal";
                      isLogin = false;
                    }

                    var snackBar = SnackBar(
                      content: Text(msg),
                      backgroundColor: isLogin ? Colors.green[700] : Colors.red[800],
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    print('Username: ${userController.text}');
                    print('Password: ${passwordController.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 57, 70, 255),
                    foregroundColor: Colors.white,
                    shape: StadiumBorder(),
                  ),
                  child: Text('Log In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tambahkan kode MyStatefulWidget jika belum ada
class MyStatefulWidget extends StatelessWidget {
  const MyStatefulWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu', style: TextStyles.title,),
        centerTitle: true,
        backgroundColor: AppColors.darkGrey,
        elevation: 0,
      ),
      body: Center(
        child: Text('Anda berhasil login!', style: TextStyles.body,),
      ),
    ); 
  }
}

// Tambahkan kode styles jika belum ada
class TextStyles {
  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.bold,
  );
  static const TextStyle body = TextStyle();
}

class AppColors {
  static const Color darkGrey = Color(0xFF616161);
}

// Tambahkan kode custom_textfield jika belum ada
class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String hint;
  final bool isObscure;
  final bool hasSuffix;
  final VoidCallback? onPressed;

  const CustomTextfield({
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
    required this.hint,
    this.isObscure = false,
    this.hasSuffix = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyles.body,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: isObscure,
      decoration: InputDecoration(
        suffixIcon: hasSuffix
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off))
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColors.darkGrey,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            color: AppColors.darkGrey,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        hintText: hint,
        hintStyle: TextStyles.body,
      ),
    );
  }
}