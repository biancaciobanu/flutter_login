import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'second_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: MyApp()));
}

final _auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isEmpty = true;
  bool viewPassword = true;
  bool showValidation = false;
  String passwordField = '';
  String emailField = '';

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      checkEmpty();
    });
    passwordController.addListener(() {
      checkEmpty();
    });
  }

  void checkEmpty() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        isEmpty = false;
      });
    } else {
      setState(() {
        isEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Image(image: AssetImage('assets/images/login_background.svg')),
          const Text(
            "CityGo Login",
            style: TextStyle(
              color: Colors.purple,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Form(
            child: TextFormField(
              controller: emailController,
              onChanged: (value) {
                emailField = value;
              },
              decoration: InputDecoration(
                label: const Text('Email'),
                labelStyle:
                    TextStyle(color: showValidation ? Colors.red : Colors.grey),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 22.0,
          ),
          Form(
            child: TextFormField(
              obscureText: viewPassword,
              controller: passwordController,
              onChanged: (value) {
                passwordField = value;
              },
              decoration: InputDecoration(
                label: const Text('Password'),
                labelStyle:
                    TextStyle(color: showValidation ? Colors.red : Colors.green),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: viewPassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      viewPassword = !viewPassword;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 88.0,
          ),
          SizedBox(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: Colors.grey,
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              onPressed: (isEmpty
                  ? null
                  : () async {
                      try {
                        await _auth.signInWithEmailAndPassword(
                            email: emailField, password: passwordField);
                      } catch (e) {
                        return setState(() {
                          showValidation = true;
                        });
                      }

                      if (mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    SecondScreen(email: emailField)));
                      }
                    }),
              child: const Text("Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  // Implementation of the login function

}
