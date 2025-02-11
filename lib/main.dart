import 'package:flutter/material.dart';
import 'DetailPageYeon.dart';
import 'DetailPageHoon.dart';
import 'DetailPageHyeon.dart';
import 'DetailPageMin.dart';
import 'DetailPageRam.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingAndTeamScreen(),
    );
  }
}

class OnboardingAndTeamScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        //physics: BouncingScrollPhysics(),
        slivers: [
          // Sliver for Onboarding Pages
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: _pageController,
                children: [
                  OnboardingPage(
                    subMessage: "따뜻한 이불 속으로...",
                  ),
                ],
              ),
            ),
          ),
          // Sliver for Team Introduction
          SliverToBoxAdapter(
            child: TeamIntroduction(),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String subMessage;

  const OnboardingPage({
    required this.subMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8F9FF), Color(0xFFF9FBF8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Add your image here
          Positioned(
            top: 250, // Adjust the position as needed
            child: Image.asset(
              'images/main.png',
              height: 446.82,
            ),
          ),
          Positioned(
            bottom: 50,
            child: Column(
              children: [
                Text(
                  subMessage,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "HS유지체",
                  ),
                ),
                SizedBox(height: 10),
                Icon(
                  Icons.arrow_downward,
                  color: Colors.yellow.shade700,
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeamIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF9FBF8),
            Color(0xFFFFFAF1),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 90,
            horizontal: 20,
          ),
          child: Column(
            children: [
              // Team image
              Image.asset('images/balloon.png'),
              SizedBox(height: 16),
              // Team name
              Text(
                "이불 밖은 위험해!",
                style: TextStyle(
                  fontFamily: "HS유지체",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              // 박스 안에 팀원 소개를 포함
              Container(
                width: 480,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      MemberRow(
                        imagePath: 'images/ram.png',
                        name: "예람핑",
                        mbti: "ENTP",
                        role: "불꽃 카리스마 팀장",
                        page: DetailPageRam(),
                        isImageFirst: true,
                      ),
                      MemberRow(
                        imagePath: 'images/yeon.png',
                        name: "서연핑",
                        mbti: "ISTJ",
                        page:DetailPageYeon(),
                        role: "벌레 단속 세스코",
                        isImageFirst: false,
                      ),
                      MemberRow(
                        imagePath: 'images/min.png',
                        name: "지민핑",
                        mbti: "ISTP",
                        role: "칼퇴 요정 뽀로로",
                        page: DetailPageMin(),
                        isImageFirst: true,
                      ),
                      MemberRow(
                        imagePath: 'images/hoon.png',
                        name: "성훈핑",
                        mbti: "ISFP",
                        role: "출결 담당 너구리",
                        page: DetailPageHoon(),
                        isImageFirst: false,
                      ),
                      MemberRow(
                        imagePath: 'images/hyeon.png',
                        name: "양현핑",
                        mbti: "ISFP",
                        page: DetailPageHyeon(),
                        role: "기술 담당 인도인",
                        isImageFirst: true,
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
}

class MemberRow extends StatelessWidget {
  final String imagePath;
  final String name;
  final String mbti;
  final String role;
  final Widget page; // 이 부분에서 개별 페이지를 받음
  final bool isImageFirst;

  const MemberRow({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.mbti,
    required this.role,
    required this.page,  // 페이지를 넘겨받음
    required this.isImageFirst,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,  // 해당 페이지로 이동
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isImageFirst
              ? [
            Hero(
              tag: name, // Hero 애니메이션 태그
              child: Image.asset(imagePath),
            ),
            SizedBox(width: 20),
            MemberInfo(name: name, mbti: mbti, role: role),
          ]
              : [
            MemberInfo(name: name, mbti: mbti, role: role),
            SizedBox(width: 20),
            Hero(
              tag: name, // Hero 애니메이션 태그
              child: Image.asset(imagePath),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying a member's name, MBTI, and role
class MemberInfo extends StatelessWidget {
  final String name;
  final String mbti;
  final String role;

  const MemberInfo({
    Key? key,
    required this.name,
    required this.mbti,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: "Pretandard",
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "$mbti\n$role",
          style: TextStyle(
            fontFamily: "Pretandard",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
