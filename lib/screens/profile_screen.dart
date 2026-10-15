import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../widgets/skill_chip.dart';
import '../widgets/info_tile.dart';

/// The main Profile Screen implemented as a StatefulWidget.
/// It showcases Flutter layouts (Stack, Container, Row, Column, Expanded)
/// and handles interactive state such as follow/unfollow and contact modal.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Interactive State Variables
  bool _isFollowing = false;
  int _followersCount = 1240;
  final int _projectsCount = 14;
  final int _followingCount = 285;

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
      _followersCount += _isFollowing ? 1 : -1;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFollowing
              ? 'You are now following Umais Ur Rehman!'
              : 'Unfollowed Umais Ur Rehman',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showContactModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const InfoTile(
                icon: Icons.email_outlined,
                title: 'Email Address',
                subtitle: 'umaisurrehman47@gmail.com',
              ),
              const InfoTile(
                icon: Icons.link,
                title: 'GitHub Profile',
                subtitle: 'github.com/umaisurrehman',
              ),
              const InfoTile(
                icon: Icons.work_outline,
                title: 'Internship Status',
                subtitle: 'Flutter Developer Intern at appverse technologies',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile link copied to clipboard!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ==========================================
            // 1. HERO HEADER USING STACK & CONTAINER
            // ==========================================
            SizedBox(
              height: 200,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Background Cover Banner using Container
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 135,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF0F172A), // Slate 900
                            Color(0xFF1E3A8A), // Blue 900
                            Color(0xFF2563EB), // Blue 600
                          ],
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.15),
                        ),
                      ),
                    ),
                  ),

                  // Overlapping Circular Avatar with Stack Indicator
                  Positioned(
                    top: 75,
                    child: Stack(
                      children: [
                        // Avatar Outer Border Container
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 54,
                            backgroundColor: const Color(0xFFE2E8F0),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/profile.jpeg',
                                width: 108,
                                height: 108,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Graceful fallback if user hasn't added their photo yet
                                  return Container(
                                    color: const Color(0xFF1E293B),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'UR',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        // Online Status Badge Dot using Positioned inside Stack
                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: const Color(0xFF22C55E), // Green 500
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ==========================================
            // 2. NAME, BADGE & BIO SECTION (COLUMN)
            // ==========================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Full Name
                  const Text(
                    'Umais Ur Rehman',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Job / Intern Role
                  const Text(
                    'Flutter Developer Intern',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Location Tag using Row
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: Color(0xFF64748B),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Gujranwala, Pakistan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Bio Card using Container
                  Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Text(
                      'Dedicated computer science student and passionate Flutter Intern developer. Eager to master clean architecture, reusable UI component design, and state management in modern mobile applications.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF475569),
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ==========================================
                  // 3. STATISTICS SECTION USING ROW & EXPANDED
                  // ==========================================
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.code,
                          value: '$_projectsCount',
                          label: 'Projects',
                          iconColor: const Color(0xFF2563EB),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.people_outline,
                          value: '$_followersCount',
                          label: 'Followers',
                          iconColor: const Color(0xFF10B981),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.person_add_alt,
                          value: '$_followingCount',
                          label: 'Following',
                          iconColor: const Color(0xFF8B5CF6),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // ==========================================
                  // 4. ACTION BUTTONS (ROW & EXPANDED)
                  // ==========================================
                  Row(
                    children: [
                      // Interactive Follow Button (StatefulWidget demonstration)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _toggleFollow,
                          icon: Icon(
                            _isFollowing
                                ? Icons.check_circle_outline
                                : Icons.person_add_outlined,
                            size: 18,
                          ),
                          label: Text(
                            _isFollowing ? 'Following' : 'Follow',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isFollowing
                                ? const Color(0xFFE2E8F0)
                                : const Color(0xFF2563EB),
                            foregroundColor: _isFollowing
                                ? const Color(0xFF0F172A)
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Contact / Message Button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _showContactModal,
                          icon: const Icon(Icons.mail_outline, size: 18),
                          label: const Text(
                            'Message',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0F172A),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ==========================================
                  // 5. SKILLS & TECHNICAL BACKGROUND SECTION
                  // ==========================================
                  Row(
                    children: const [
                      Icon(
                        Icons.psychology_outlined,
                        size: 20,
                        color: Color(0xFF2563EB),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Technical Skills & Technologies',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Reusable SkillChips wrapped cleanly
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: const [
                      SkillChip(
                        label: 'Flutter',
                        icon: Icons.flutter_dash,
                        backgroundColor: Color(0xFFEFF6FF),
                        textColor: Color(0xFF1D4ED8),
                      ),
                      SkillChip(
                        label: 'Dart',
                        icon: Icons.code,
                        backgroundColor: Color(0xFFF0FDF4),
                        textColor: Color(0xFF15803D),
                      ),
                      SkillChip(
                        label: 'Widget Architecture',
                        icon: Icons.widgets_outlined,
                        backgroundColor: Color(0xFFFAF5FF),
                        textColor: Color(0xFF7E22CE),
                      ),
                      SkillChip(
                        label: 'UI/UX Design',
                        icon: Icons.palette_outlined,
                        backgroundColor: Color(0xFFFFFBEB),
                        textColor: Color(0xFFB45309),
                      ),
                      SkillChip(
                        label: 'Git & GitHub',
                        icon: Icons.terminal,
                        backgroundColor: Color(0xFFF1F5F9),
                        textColor: Color(0xFF334155),
                      ),
                      SkillChip(
                        label: 'State Management',
                        icon: Icons.sync_alt,
                        backgroundColor: Color(0xFFFEF2F2),
                        textColor: Color(0xFFB91C1C),
                      ),
                      SkillChip(
                        label: 'REST APIs',
                        icon: Icons.cloud_outlined,
                        backgroundColor: Color(0xFFF0FDFA),
                        textColor: Color(0xFF0F766E),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ==========================================
                  // 6. ACADEMIC & PROFESSIONAL DETAILS
                  // ==========================================
                  Row(
                    children: const [
                      Icon(
                        Icons.badge_outlined,
                        size: 20,
                        color: Color(0xFF2563EB),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Academic & Role Details',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  InfoTile(
                    icon: Icons.school_outlined,
                    title: 'Current Role',
                    subtitle: 'Flutter Internship Developer',
                    onTap: () {},
                  ),
                  InfoTile(
                    icon: Icons.assignment_outlined,
                    title: 'Project Title',
                    subtitle: 'Profile Screen Component Architecture',
                    onTap: () {},
                  ),
                  InfoTile(
                    icon: Icons.verified_user_outlined,
                    title: 'Student Name',
                    subtitle: 'Umais Ur Rehman',
                    onTap: () {},
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
