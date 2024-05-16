import 'package:badmiton_app/constant/Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constant/ConstantRoutes.dart';
import '../../../../controller/logincontroller/logincontroller.dart';

class LoginFormValidation extends StatefulWidget {
  const LoginFormValidation({super.key});

  @override
  State<LoginFormValidation> createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<LoginFormValidation> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        height: Screens.bodyheight(context),
        width: Screens.width(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('lib/assets/logonew.png'))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  // right: Screens.width(context) * 0.04,
                  left: Screens.width(context) * 0.03,
                  top: Screens.bodyheight(context) * 0.15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: theme.textTheme.displaySmall!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      'Signin',
                      style: theme.textTheme.displaySmall!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Screens.bodyheight(context) * 0.07),
              // Positioned(
              //   top: Screens.bodyheight(context) * 0.27,
              //   right: Screens.width(context) * 0.2,
              // //   child: Container(
              // //       decoration: const BoxDecoration(
              // //           color: Colors.white, shape: BoxShape.circle),
              // //       child: Image.asset(
              // //         'lib/assets/Badmiton_pure.png',
              // //         scale: 1.2,
              // //         fit: BoxFit.fill,
              // //       )),
              // //   //
              // //   // Container(
              // //   // height: Screens.bodyheight(context) * 0.25,
              // //   // width: Screens.width(context) * 0.3,
              // //   //     padding: EdgeInsets.all(Screens.bodyheight(context) * 0.01),
              // //   // decoration: const BoxDecoration(
              // //   //     color: Colors.green, shape: BoxShape.circle),
              // //   // child: Image.asset(
              // //   //   'assets/Badmiton_pure.png',
              // //   //   scale: 1.2,
              // //   // ),
              // //   //   ),
              // // ),
              // nnnn
              Container(
                padding: EdgeInsets.only(
                  right: Screens.width(context) * 0.04,
                  left: Screens.width(context) * 0.04,
                  top: Screens.bodyheight(context) * 0.2,
                ),
                alignment: Alignment.center,
                child: Container(
                  color: Colors.white,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: context.watch<LoginCtrl>().formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                                child: TextFormField(
                                  controller:
                                      context.watch<LoginCtrl>().userrnameCtrlr,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter username';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: 'Enter Your Username',
                                    prefixIcon:
                                        const Icon(Icons.person_2_outlined),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                  height: Screens.bodyheight(context) * 0.02),

                              // _gap(),
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                  controller:
                                      context.watch<LoginCtrl>().passWordCtrlr,
                                  obscureText: !isPasswordVisible,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: 'Enter Your Password',
                                      prefixIcon:
                                          const Icon(Icons.lock_outline),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(isPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible;
                                          });
                                        },
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Screens.bodyheight(context) * 0.03),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              if (context
                                      .read<LoginCtrl>()
                                      .formKey
                                      .currentState
                                      ?.validate() ??
                                  false) {
                                Get.offAllNamed(ConstantRoutes.dashboard);
                              }
                            },
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
      // Stack(
      //   clipBehavior: Clip.none,
      //   children: [

      //   ],
      // ),

      // Add more widgets here if you need them
    );
  }

  Widget _gap() => const SizedBox(height: 20);
}

class CustomShapePainter extends CustomPainter {
  final Color primaryColor;
  CustomShapePainter(this.primaryColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = primaryColor
      ..strokeWidth = 15;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 1.22);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      var rect = Offset.zero & size;
      var width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      return [
        CustomPainterSemantics(
          rect: rect,
          properties: const SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  @override
  bool shouldRepaint(CustomShapePainter oldDelegate) => false;
}

// import 'package:badmiton_app/constant/ConstantRoutes.dart';
// import 'package:badmiton_app/constant/Screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/semantics.dart';
// import 'package:get/get.dart';

// class LoginFormValidation extends StatefulWidget {
//   const LoginFormValidation({super.key});

//   @override
//   State<LoginFormValidation> createState() => _LoginFormValidationState();
// }

// class _LoginFormValidationState extends State<LoginFormValidation> {
//   bool _isPasswordVisible = false;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
//             height: double.infinity,
//             width: double.infinity,
//             color: Colors.white,
//             child: SingleChildScrollView(
//               child:
//                   Column(mainAxisAlignment: MainAxisAlignment.end, children: [
//                 Container(
//                   alignment: Alignment.bottomCenter,
//                   height: Screens.bodyheight(context) * 0.83,
//                   width: Screens.width(context),
//                   // color: Colors.indigo,
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 5,
//                               blurRadius: 7,
//                               offset: const Offset(
//                                   0, 3), // changes position of shadow
//                             ),
//                           ]),
//                           child: TextFormField(
//                             validator: (value) {
//                               // add email validation
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter username';
//                               }
//                               // bool emailValid = RegExp(
//                               //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                               //     .hasMatch(value);
//                               // if (!emailValid) {
//                               //   return 'Please enter a valid email';
//                               // }

//                               return null;
//                             },
//                             decoration: InputDecoration(
//                               contentPadding: const EdgeInsets.fromLTRB(
//                                   20.0, 15.0, 20.0, 15.0),
//                               labelText: 'Username',
//                               labelStyle: theme.textTheme.bodyMedium
//                                   ?.copyWith(color: Colors.black),
//                               hintText: 'Enter your Username',
//                               hintStyle: theme.textTheme.bodyMedium
//                                   ?.copyWith(color: Colors.black),
//                               prefixIcon: const Icon(Icons.person_2_outlined),
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         _gap(),
//                         Container(
//                           decoration: BoxDecoration(boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 5,
//                               blurRadius: 7,
//                               offset: const Offset(
//                                   0, 3), // changes position of shadow
//                             ),
//                           ]),
//                           child: TextFormField(
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter password';
//                               }
//                               if (value.length < 6) {
//                                 return 'Password must be at least 6 characters';
//                               }
//                               return null;
//                             },
//                             obscureText: !_isPasswordVisible,
//                             decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.fromLTRB(
//                                     20.0, 15.0, 20.0, 15.0),
//                                 labelText: 'Password',
//                                 hintText: 'Enter your password',
//                                 prefixIcon: const Icon(Icons.lock_outline),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(_isPasswordVisible
//                                       ? Icons.visibility_off
//                                       : Icons.visibility),
//                                   onPressed: () {
//                                     setState(() {
//                                       _isPasswordVisible = !_isPasswordVisible;
//                                     });
//                                   },
//                                 )),
//                           ),
//                         ),
//                         _gap(),
//                         // CheckboxListTile(
//                         //   value: _rememberMe,
//                         //   onChanged: (value) {
//                         //     if (value == null) return;
//                         //     setState(() {
//                         //       _rememberMe = value;
//                         //     });
//                         //   },
//                         //   title: const Text('Remember me'),
//                         //   controlAffinity: ListTileControlAffinity.leading,
//                         //   dense: true,
//                         //   contentPadding: const EdgeInsets.all(0),
//                         // ),
//                         _gap(),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: theme.primaryColor,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(4)),
//                             ),
//                             child: const Padding(
//                               padding: EdgeInsets.all(10.0),
//                               child: Text(
//                                 'Login',
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState?.validate() ?? false) {
//                                 Get.toNamed(ConstantRoutes.dashboard);
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ]),
//             ),
//           ),
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               CustomPaint(
//                 size: Size(MediaQuery.of(context).size.width,
//                     300), // You can adjust the height here
//                 painter: CustomShapePainter(Theme.of(context).primaryColor),
//               ),
//               Positioned(
//                 top: Screens.bodyheight(context) * 0.24,
//                 right: 45,
//                 child: Container(
//                   height: Screens.bodyheight(context) * 0.25,
//                   width: Screens.width(context) * 0.3,
//                   padding: EdgeInsets.all(Screens.bodyheight(context) * 0.01),
//                   decoration: const BoxDecoration(
//                       // image: DecorationImage(
//                       //     image: AssetImage('lib/assets/Badmiton_pure.png')),
//                       color: Colors.white,
//                       shape: BoxShape.circle),
//                   child: Image.asset(
//                     'lib/assets/Badmiton_pure.png',
//                     // fit: BoxFit.fill,
//                     scale: 1.2,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Positioned(
//             top: Screens.bodyheight(context) * 0.15,
//             left: 20,
//             child: Container(
//               height: Screens.bodyheight(context) * 0.2,
//               width: Screens.width(context),
//               decoration: const BoxDecoration(
//                   // image: DecorationImage(
//                   //     image: AssetImage('lib/assets/web-badminton-getty.avif')),
//                   // color: Colors.white,
//                   ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Welcome to',
//                     style: theme.textTheme.displaySmall!
//                         .copyWith(color: Colors.white),
//                   ),
//                   Text(
//                     'Signin',
//                     style: theme.textTheme.displaySmall!
//                         .copyWith(color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Add more widgets here if you need them
//         ],
//       ),
//     );
//   }

//   Widget _gap() => const SizedBox(height: 20);
// }

// class CustomShapePainter extends CustomPainter {
//   final Color primaryColor;
//   CustomShapePainter(this.primaryColor);

//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = primaryColor
//       ..strokeWidth = 15;

//     var path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height * 0.8);
//     path.lineTo(size.width * 0.5, size.height);
//     path.lineTo(0, size.height * 1.22);
//     path.lineTo(0, 0);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   SemanticsBuilderCallback get semanticsBuilder {
//     return (Size size) {
//       var rect = Offset.zero & size;
//       var width = size.shortestSide * 0.4;
//       rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
//       return [
//         CustomPainterSemantics(
//           rect: rect,
//           properties: const SemanticsProperties(
//             label: 'Sun',
//             textDirection: TextDirection.ltr,
//           ),
//         ),
//       ];
//     };
//   }

//   @override
//   bool shouldRepaint(CustomShapePainter oldDelegate) => false;
// }

// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         title: const Text("Login Page"),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Form(
// //           autovalidateMode: AutovalidateMode
// //               .onUserInteraction, //check for validation while typing
// //           key: formkey,
// //           child: Column(
// //             children: <Widget>[
// //               SizedBox(
// //                 height: Screens.bodyheight(context) * 0.2,
// //               ),
// //               // Padding(
// //               //   padding: const EdgeInsets.only(top: 60.0),
// //               //   child: Center(
// //               //     child: SizedBox(
// //               //         width: 200,
// //               //         height: 150,
// //               //         child: Image.asset('asset/images/flutter-logo.png')),
// //               //   ),
// //               // ),
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 15),
// //                 child: TextFormField(
// //                     decoration: const InputDecoration(
// //                         border: OutlineInputBorder(),
// //                         labelText: 'Email',
// //                         hintText: 'Enter valid email id as abc@gmail.com'),
// //                     validator: MultiValidator([
// //                       RequiredValidator(errorText: "* Enter valid email id"),
// //                       EmailValidator(errorText: "Enter valid email id"),
// //                     ]).call),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.only(
// //                     left: 15.0, right: 15.0, top: 15, bottom: 0),
// //                 child: TextFormField(
// //                     obscureText: true,
// //                     decoration: const InputDecoration(
// //                         border: OutlineInputBorder(),
// //                         labelText: 'Password',
// //                         hintText: 'Enter secure password'),
// //                     validator: MultiValidator([
// //                       RequiredValidator(
// //                           errorText: "* Enter the valid password"),
// //                       MinLengthValidator(6,
// //                           errorText: "Password should be atleast 6 characters"),
// //                       MaxLengthValidator(15,
// //                           errorText:
// //                               "Password should not be greater than 15 characters")
// //                     ]).call
// //                     //validatePassword,        //Function to check validation
// //                     ),
// //               ),
// //               TextButton(
// //                 onPressed: () {
// //                   //TODO FORGOT PASSWORD SCREEN GOES HERE
// //                 },
// //                 child: const Text(
// //                   'Forgot Password',
// //                   style: TextStyle(color: Colors.blue, fontSize: 15),
// //                 ),
// //               ),
// //               Container(
// //                 height: 50,
// //                 width: 250,
// //                 decoration: BoxDecoration(
// //                     color: Colors.blue,
// //                     borderRadius: BorderRadius.circular(20)),
// //                 child: TextButton(
// //                   onPressed: () {
// //                     if (formkey.currentState!.validate()) {
// //                       Navigator.push(context,
// //                           MaterialPageRoute(builder: (_) => const DashBoard()));
// //                       print("Validated");
// //                     } else {
// //                       print("Not Validated");
// //                     }
// //                   },
// //                   child: const Text(
// //                     'Login',
// //                     style: TextStyle(color: Colors.white, fontSize: 25),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 100,
// //               ),
// //               const Text('New User? Create Account')
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
