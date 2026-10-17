import 'package:flutter/material.dart';

/// Comprehensive Form Screen demonstrating:
/// - Form and FormState with GlobalKey FormState
/// - TextFormField with custom InputDecoration
/// - Synchronous and regex-based input validation
/// - Diverse input widgets (Dropdown, Switch, Checkbox)
/// - User interaction handling (Submit, Reset, Focus traversal, SnackBars)
class UserRegistrationFormScreen extends StatefulWidget {
  const UserRegistrationFormScreen({super.key});

  @override
  State<UserRegistrationFormScreen> createState() =>
      _UserRegistrationFormScreenState();
}

class _UserRegistrationFormScreenState
    extends State<UserRegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();

  // Focus Nodes
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _bioFocus = FocusNode();

  // Form State Values
  String? _selectedRole = 'Flutter Developer';
  bool _isAvailableForHire = true;
  bool _agreedToTerms = false;
  bool _submitted = false;

  final List<String> _roles = [
    'Flutter Developer',
    'Mobile UI/UX Designer',
    'Full Stack Dart Engineer',
    'QA & Automation Specialist',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _bioFocus.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      if (!_agreedToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree to terms and conditions to proceed.'),
            backgroundColor: Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      // Valid submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Form Validated & Submitted Successfully!',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF16A34A),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );

      // Show summary dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Registration Summary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${_nameController.text}'),
              const SizedBox(height: 4),
              Text('Email: ${_emailController.text}'),
              const SizedBox(height: 4),
              Text('Phone: ${_phoneController.text}'),
              const SizedBox(height: 4),
              Text('Role: $_selectedRole'),
              const SizedBox(height: 4),
              Text('Available: ${_isAvailableForHire ? "Yes" : "No"}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _bioController.clear();
    setState(() {
      _selectedRole = 'Flutter Developer';
      _isAvailableForHire = true;
      _agreedToTerms = false;
      _submitted = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form has been reset to defaults.'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'UI Foundations: Forms & Input',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _submitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E293B), Color(0xFF2563EB)],
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Candidate Profile & Form Validation',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Phase 1: Input Widgets, Validation Rules & Interaction Flow',
                      style: TextStyle(color: Color(0xFF93C5FD), fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Full Name Field
              const Text(
                'Full Name *',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_emailFocus),
                decoration: InputDecoration(
                  hintText: 'e.g. Umais Ur Rehman',
                  prefixIcon: const Icon(Icons.person_outline, size: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full name is required.';
                  }
                  if (value.trim().length < 3) {
                    return 'Name must contain at least 3 characters.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Email Address Field with Regex
              const Text(
                'Email Address *',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_phoneFocus),
                decoration: InputDecoration(
                  hintText: 'e.g. umais@example.com',
                  prefixIcon: const Icon(Icons.email_outlined, size: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email address is required.';
                  }
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Please enter a valid email format (name@domain.com).';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Phone Number Field
              const Text(
                'Phone Number *',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _phoneController,
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_bioFocus),
                decoration: InputDecoration(
                  hintText: 'e.g. 03001234567',
                  prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone number is required.';
                  }
                  if (value.trim().length < 10) {
                    return 'Phone number must be at least 10 digits.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Professional Role Dropdown
              const Text(
                'Designation / Role',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedRole,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.badge_outlined, size: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
                items: _roles
                    .map(
                      (role) => DropdownMenuItem(
                        value: role,
                        child: Text(role, style: const TextStyle(fontSize: 14)),
                      ),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedRole = val),
              ),

              const SizedBox(height: 16),

              // Bio / Statement Field
              const Text(
                'Professional Statement',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _bioController,
                focusNode: _bioFocus,
                maxLines: 3,
                maxLength: 150,
                decoration: InputDecoration(
                  hintText: 'Brief summary of Flutter learning goals...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Availability Switch
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: SwitchListTile(
                  title: const Text(
                    'Available for Full-Time Internship',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                  ),
                  subtitle: const Text(
                    'Receive automated team notifications',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
                  ),
                  value: _isAvailableForHire,
                  onChanged: (val) => setState(() => _isAvailableForHire = val),
                  activeThumbColor: const Color(0xFF2563EB),
                ),
              ),

              const SizedBox(height: 12),

              // Checkbox for Terms
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  'I confirm the submitted information is accurate and agree to development standards.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
                ),
                value: _agreedToTerms,
                onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
              ),

              const SizedBox(height: 20),

              // Action Buttons Row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.send_rounded, size: 18),
                      label: const Text(
                        'Submit Form',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _resetForm,
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text(
                        'Reset',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF475569),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
