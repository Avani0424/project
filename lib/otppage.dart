import 'package:flutter/material.dart';
import 'package:miniproject/confirm.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  // Function to validate OTP
  bool isOTPValid() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Set padding and element sizes based on screen size
    double horizontalPadding = screenWidth * 0.05; // 5% of screen width
    double verticalPadding = screenHeight * 0.02; // 2% of screen height
    double imageHeight = screenHeight * 0.3; // 30% of screen height
    double textFieldWidth = screenWidth * 0.12; // 12% of screen width

    return Scaffold(
      backgroundColor: const Color(0xFFF7ECEC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: verticalPadding),
            Padding(
              padding: EdgeInsets.all(horizontalPadding),
              child: Image.asset(
                'assets/images/otp.png',
                height: imageHeight,
              ),
            ),
            SizedBox(height: verticalPadding),
            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: verticalPadding * 0.5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Please enter the 4-digit OTP sent to your registered email address.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            SizedBox(height: verticalPadding * 1.5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: textFieldWidth,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 3) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index + 1]);
                          }
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index - 1]);
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: verticalPadding * 2),
            ElevatedButton(
              onPressed: () {
                if (isOTPValid()) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Confirm(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = 0.0;
                        var end = 1.0;
                        var tween = Tween(begin: begin, end: end);
                        var fadeAnimation = animation.drive(tween);

                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                } else {
                  // Show a snackbar or alert dialog if OTP is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter the full OTP.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'VERIFY',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: verticalPadding * 2),
          ],
        ),
      ),
    );
  }
}
