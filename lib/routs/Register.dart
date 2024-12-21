import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recho/routs/HomePage.dart';
import 'package:recho/routs/login.dart';
import 'package:recho/widgets/Text_Field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late final uid;
  final DatabaseReference _dataRef = FirebaseDatabase.instance.ref().child('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _register(String phoneNumber,String password) async {


    if (_formKey.currentState!.validate()) {
      try {
        String email='$phoneNumber@recho.com';
        // String email=_emailController.text;
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // credential.user!.updateDisplayName(_fullNameController.text);
        credential.user?.updateDisplayName(_fullNameController.text);
        print("fullnameController from register ${_fullNameController.text}");
        // await firebaseDatabase.push().set({
        //   'userName': userNameController.text,
        //   'email': emailController.text,
        //   'password': passwordController.text,
        //   'userId': credential.user?.uid,
        // });
        // userNameController.clear();

        // CacheHelper.putBoolData(key: "isLogin", value:true);
        // CacheHelper.putData(key: "userId", value: credential.user!.uid.toString());
        // CacheHelper.putData(key: "email", value: credential.user!.email.toString());
        // CacheHelper.putData(key: "userName", value: userNameController.text);

        final User? user = _auth.currentUser;
        uid = user!.uid;

        _dataRef.push().set({
          'UserUid': uid,
          'UserName': _fullNameController.text,
          'email': _emailController.text,
          'phoneNumber':_phoneController.text,
          'password':_passwordController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم التسجيل بنجاح')),
        );

        // Reset form fields after submission
        _formKey.currentState!.reset();
        _passwordController.clear();
        _confirmPasswordController.clear();
        _fullNameController.clear();
        _emailController.clear();
        _phoneController.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));



      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('كلمه المرور ضعيفه')),
          );
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that phone number.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('هذا الحساب موجود بالفعل')),
          );
        }
      } catch (e) {
        print(e);
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تأكد من إدخال جميع الحقول بشكل صحيح')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Recho',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'أدخل بياناتك للتسجيل',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                buildTextField(
                  label: 'الاسم الكامل',
                  controller: _fullNameController,
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return 'يجب أن يكون الاسم 3 أحرف على الأقل';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                buildTextField(
                  label: 'البريد الإلكتروني',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'البريد الإلكتروني غير صحيح';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                buildTextField(
                  label: 'رقم الجوال',
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.length !< 10) {
                      return 'رقم الجوال غير صحيح';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                buildTextField(
                  label: 'كلمة المرور',
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return "يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                buildTextField(
                  label: 'تأكيد كلمة المرور',
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'كلمة المرور غير متطابقة';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                    _register(_phoneController.text, _passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'تسجيل',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Navigate to the login screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    'لديك حساب بالفعل؟ تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
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


