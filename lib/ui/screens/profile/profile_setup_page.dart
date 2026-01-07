import 'package:flutter/material.dart';
import '../home_page.dart';
import 'profile_photo_page.dart';
import '../../../data/user_progress_repository.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _statusMessage;
  String? _passwordError;
  bool _obscurePassword = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _statusMessage = null; 
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _statusMessage = null; 
      });
    });
  }

  void _validatePassword() {
    final password = _passwordController.text;
    if (password.isEmpty) {
      _passwordError = null;
    } else if (password.length < 8) {
      _passwordError = 'Password must be at least 8 characters';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password)) {
      _passwordError = 'Password must contain only letters and numbers';
    } else {
      _passwordError = null;
    }
  }

  bool _isPasswordValid() {
    final password = _passwordController.text;
    return password.length >= 8 && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile_bg.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF1E293B),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Title
                  Text(
                    _selectedIndex == 0 ? 'Welcome Back' : 'Create Account',
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedIndex == 0
                        ? 'Login to your account'
                        : 'Sign up to get started',
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Form Content
                  SizedBox(
                    height: 400,
                    child: _selectedIndex == 0
                        ? _buildLoginForm()
                        : _buildSignUpForm(),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _statusMessage = null;
            _passwordError = null;
            _isLoading = false;
            _nameController.clear();
            _passwordController.clear();
          });
        },
        selectedItemColor: const Color(0xFF10B981),
        unselectedItemColor: const Color(0xFF94A3B8),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Full Name Input
          TextField(
            controller: _nameController,
            style: const TextStyle(color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: 'Full Name',
              hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Color(0xFF64748B),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Password Input
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: const TextStyle(color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: '• • • • • • • •',
              hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF64748B),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: const Color(0xFF64748B),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          if (_passwordError != null && _passwordController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFEF4444),
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _passwordError!,
                      style: const TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          if (_statusMessage != null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color:
                    _statusMessage!.contains('Incorrect') ||
                        _statusMessage!.contains('Error')
                    ? const Color(0xFFFEE2E2)
                    : const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _statusMessage!.contains('Incorrect') ||
                            _statusMessage!.contains('Error')
                        ? Icons.error_outline
                        : Icons.check_circle_outline,
                    color:
                        _statusMessage!.contains('Incorrect') ||
                            _statusMessage!.contains('Error')
                        ? const Color(0xFFDC2626)
                        : const Color(0xFF16A34A),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _statusMessage!,
                      style: TextStyle(
                        color:
                            _statusMessage!.contains('Incorrect') ||
                                _statusMessage!.contains('Error')
                            ? const Color(0xFFDC2626)
                            : const Color(0xFF16A34A),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  (_nameController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      !_isPasswordValid() ||
                      _isLoading)
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                        _statusMessage = null;
                      });

                      final enteredName = _nameController.text.trim();
                      final enteredPassword = _passwordController.text.trim();

                      // Check if user exists
                      final exists = await userExists(enteredName);

                      if (exists) {
                        // Existing user - validate password
                        final isValidPassword = await validateUserPassword(
                          enteredName,
                          enteredPassword,
                        );

                        if (isValidPassword) {
                          // Correct password - load their data
                          await loadUserData(enteredName);

                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                            );
                          }
                        } else {
                          // Wrong password
                          setState(() {
                            _isLoading = false;
                            _statusMessage =
                                'Incorrect password. Please try again.';
                          });
                        }
                      } else {
                        // User doesn't exist
                        setState(() {
                          _isLoading = false;
                          _statusMessage =
                              'User not found. Please sign up first.';
                        });
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                disabledBackgroundColor: const Color(0xFFE2E8F0),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Full Name Input
          TextField(
            controller: _nameController,
            style: const TextStyle(color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: 'Full Name',
              hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Color(0xFF64748B),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Password Input
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: const TextStyle(color: Color(0xFF1E293B)),
            decoration: InputDecoration(
              hintText: '• • • • • • • •',
              hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF64748B),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: const Color(0xFF64748B),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Password validation error
          if (_passwordError != null && _passwordController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFEF4444),
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _passwordError!,
                      style: const TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // Status Message
          if (_statusMessage != null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color:
                    _statusMessage!.contains('exists') ||
                        _statusMessage!.contains('Error')
                    ? const Color(0xFFFEE2E2)
                    : const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _statusMessage!.contains('exists') ||
                            _statusMessage!.contains('Error')
                        ? Icons.error_outline
                        : Icons.check_circle_outline,
                    color:
                        _statusMessage!.contains('exists') ||
                            _statusMessage!.contains('Error')
                        ? const Color(0xFFDC2626)
                        : const Color(0xFF16A34A),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _statusMessage!,
                      style: TextStyle(
                        color:
                            _statusMessage!.contains('exists') ||
                                _statusMessage!.contains('Error')
                            ? const Color(0xFFDC2626)
                            : const Color(0xFF16A34A),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  (_nameController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      !_isPasswordValid() ||
                      _isLoading)
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                        _statusMessage = null;
                      });

                      final enteredName = _nameController.text.trim();
                      final enteredPassword = _passwordController.text.trim();

                      // Check if user already exists
                      final exists = await userExists(enteredName);

                      if (exists) {
                        setState(() {
                          _isLoading = false;
                          _statusMessage =
                              'Username already exists. Please login instead.';
                        });
                      } else {
                        try {
                          await createNewUser(enteredName, enteredPassword);

                          await loadUserData(enteredName);

                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfilePhotoPage(),
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() {
                            _isLoading = false;
                            _statusMessage =
                                'Error creating account. Please try again.';
                          });
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                disabledBackgroundColor: const Color(0xFFE2E8F0),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
