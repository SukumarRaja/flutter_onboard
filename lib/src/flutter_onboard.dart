import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class OnBoarding extends StatefulWidget {
  OnBoarding(
      {Key? key,
      required this.numberOfPages,
      required this.currentPage,
      this.indicatorActiveColor = const Color(0xFF7B51D3),
      this.indicatorDeActiveColor = const Color(0xB6B4B4FF),
      this.indicatorRadius = 12.0,
      this.skipButton,
      this.nextButton,
      required this.doneButton,
      this.skipText = "skip",
      this.nextText = "Next",
      this.doneText = "Done",
      this.skipTextColor = const Color(0xFF7B51D3),
      this.nextTextColor,
      this.doneTextColor,
      this.doneButtonRadius = 10.0,
      this.doneButtonColor = const Color(0xFF7B51D3),
      this.isShowSkip = true,
      required this.title,
      required this.body,
      required this.image,
      this.nextButtonColor = const Color(0xFF7B51D3),
      this.nextButtonRadius = 5.0})
      : super(key: key);
  final int numberOfPages;
  int currentPage;
  final Color? indicatorActiveColor;
  final Color? indicatorDeActiveColor;
  final Color? skipTextColor;
  final Color? nextTextColor;
  final Color? doneTextColor;
  final Color? doneButtonColor;
  final Color? nextButtonColor;
  final double indicatorRadius;
  final double doneButtonRadius;
  final double nextButtonRadius;
  final Function()? skipButton;
  final Function()? nextButton;
  final Function() doneButton;
  final String skipText;
  final String nextText;
  final String doneText;
  final String title;
  final String body;
  final String image;
  final bool isShowSkip;

  @override
  State<OnBoarding> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoarding> {
  PageController pageController = PageController(initialPage: 0);

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.numberOfPages; i++) {
      list.add(i == widget.currentPage ? indicator(true) : indicator(false));
    }
    return list;
  }

  Widget buildPages() {
    List<Widget> list = [];
    for (int i = 0; i < widget.numberOfPages; i++) {
      list.add(buildSlider(
          title: widget.title[i],
          content: widget.body[i],
          image: widget.image[i]));
    }
    return buildPages();
  }

  void onIntroEnd() {
    //This section used to on intro end which function you want or navigate to another page

    ///emaple
    ///AuthController.to.setOnBoardDataAfterScreenCompleted();
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive
            ? widget.indicatorActiveColor
            : widget.indicatorDeActiveColor,
        borderRadius: BorderRadius.all(Radius.circular(widget.indicatorRadius)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.isShowSkip == true
                  ? InkWell(
                      onTap: widget.skipButton,
                      child: Container(
                        height: media.width * 0.08,
                        width: media.width * 0.15,
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          // color: Color(0xFF7B51D3)
                        ),
                        alignment: Alignment.centerRight,
                        child: Center(
                          child: Text(
                            widget.skipText,
                            style: TextStyle(
                              color: widget.skipTextColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: media.height * 0.7,
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      widget.currentPage = page;
                    });
                  },
                  children: [buildPages()],
                ),
              ),
              SizedBox(
                height: media.width * 0.10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildPageIndicator(),
              ),
              widget.currentPage != widget.numberOfPages - 1
                  ? Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: InkWell(
                          onTap: () {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            height: media.width * 0.10,
                            width: media.width * 0.25,
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    widget.nextButtonRadius),
                                color: widget.nextButtonColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.nextText,
                                  style: TextStyle(
                                    color: widget.nextTextColor,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      bottomSheet: widget.currentPage == widget.numberOfPages - 1
          ? Container(
              height: media.width * 0.15,
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.doneButtonRadius),
                color: widget.doneButtonColor,
              ),
              child: GestureDetector(
                onTap: widget.doneButton,
                child: Center(
                  child: Text(
                    widget.doneText,
                    style: TextStyle(
                      color: widget.doneTextColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  Column buildSlider({required title, required content, required image}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: buildSvgPicture(imgSrc: image)),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }

  Image buildSvgPicture({required imgSrc}) {
    return Image.asset(
      "assets/images/$imgSrc.png",
    );
  }
}
