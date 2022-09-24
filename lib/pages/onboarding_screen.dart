import 'package:parkit/pages/home_page.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: demoData.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                    image: demoData[index].image,
                    title: demoData[index].title,
                    description: demoData[index].description),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // print(_pageController.page);
                    if (_pageController.page == 2.0) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomePage()));
                    } else {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                  child: Text("Next"),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.90, 50)),
                      maximumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.90, 50)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff2756FF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: Color(0xff2756FF))))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(),
                      ),
                    );
                  },
                  child: Text("Skip"),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.90, 50)),
                      maximumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width * 0.90, 50)),
                      foregroundColor:
                          MaterialStateProperty.all(Color(0xff2756FF)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffDCEEFF)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: Color(0xffDCEEFF))))),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 25 : 8,
      decoration: BoxDecoration(
          color: isActive ? Color(0xff2756FF) : Color(0xffCCCCCC),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

class Onboard {
  final String image, title, description;

  Onboard(
      {required this.image, required this.title, required this.description});
}

final List<Onboard> demoData = [
  Onboard(
      image: "assets/images/onboarding_1.png",
      title: "Find Parking Places\n Around You Easily",
      description: "Find Places To Park Around You"),
  Onboard(
      image: "assets/images/onboarding_2.png",
      title: "Book and Pay Parking\n Quickly & Safely",
      description: "Safe, Secure & Hassle Free Transactions"),
  Onboard(
      image: "assets/images/onboarding_3.png",
      title: "Extend Parking Time As\n You Need",
      description: "Need More Time ???\n We've Got You Covered.")
];

class OnboardContent extends StatelessWidget {
  const OnboardContent(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Center(child: Image.asset(image, height: 250)),
          const Spacer(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
