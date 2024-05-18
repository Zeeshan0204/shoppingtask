import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertask/core/config/size_config.dart';
import 'package:fluttertask/core/config/themes/app_colors.dart';
import 'package:fluttertask/core/utils/common.dart';
import 'package:fluttertask/core/utils/routes_strings.dart';
import 'package:fluttertask/core/utils/shared_pref.dart';
import 'package:fluttertask/core/utils/shared_pref_const.dart';
import 'package:fluttertask/presentation/bloc_logic/login_bloc/login_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Center(
            child: Image.asset("images/online-shopping.png",
            width: 200, height: 200,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Border color
                borderRadius: BorderRadius.circular(8.0), // Border radius
              ),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(

                  labelText: 'Username', // Label text above the input field
                  hintText: 'John Doe', // Hint text when the field is empty
                  prefixIcon: const Icon(Icons.person), // Icon displayed before the input field
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear), // Icon button to clear the input field
                    onPressed: () {
                      // Clear the text field
                      // You can implement your logic here
                      _usernameController.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Set border color here
                    borderRadius: BorderRadius.circular(8.0), // Set border radius here
                  ), // Border around the input field
                  // Optionally, you can customize the border with borderRadius, borderColor, etc.
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Border color
                borderRadius: BorderRadius.circular(8.0), // Border radius
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password', // Label text above the input field
                  hintText: '*********', // Hint text when the field is empty
                  prefixIcon: Icon(Icons.password_rounded), // Icon displayed before the input field
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear), // Icon button to clear the input field
                    onPressed: () {
                      // Clear the text field
                      // You can implement your logic here

                      _passwordController.clear();
                    },
                  ),
                  border:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Set border color here
                    borderRadius: BorderRadius.circular(8.0), // Set border radius here
                  ), // Border around the input field
                  // Optionally, you can customize the border with borderRadius, borderColor, etc.
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoading) {

                const Center(child: CircularProgressIndicator());

              }
              if (state is LoginSuccess) {

                  await CommonSharedPreference.setBoolValues(SharedPreferenceConstants.loginStatus, true);
                  await CommonSharedPreference.save(SharedPreferenceConstants.appAuthToken, state.LoginModel.toString());

                  Common.toastWarning(context, "Login successfully!!");

                  Navigator.pushNamed(context, RouteString.home);

              }
              if (state is LoginError) {
                Common.toastWarning(context, "Username or Password is not correct !!");

              }
            },
            child: ElevatedButton(
              onPressed: (){

                if(_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                  BlocProvider.of<LoginBloc>(context).add(LoginRefreshEvent(context,_usernameController.text.toString(), _passwordController.text.toString()));

                }else{

                  Common.toastWarning(context, "Enter username and password !!");

                }

              },
              child: const Text("Submit"),
            )

          ),

        ],
      ),
    );
  }
}
