import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Animations/bouncing_button_animation.dart';
import 'Animations/bouncingbutton.dart';
import 'responsive_widget.dart';
import 'Popup.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';

// import 'package:js/js_util.dart' as jsutil;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final aboutMe = [
    'Greetings! I am currently a Computer Science graduate student attending ',
    'The University of Central Florida. My productive spare-time ',
    'hobbies include full-stack development on web, mobile, and game applications. ',
    'I am fascinated by what machine learning can do for the society; ',
    'as a result, I am trying to get a more in-depth understanding of the application of machine learning, ',
    'and such a desire has motivated me to continue my education in graduate school. ',
    'Eventually, I would have a better understanding of the machine learning algorithms '
        'behind the scenes as I incorporate such applications & concepts into my personal projects, ',
    'and leverage such skills to contribute in the software idustry.'
  ];

  final skills = [
    'Programming languages: C#, Dart, Python, Java, C/C++, HTML/CSS/JavaScript, Bash, PowerShell\n',
    'Frameworks: Unity Engine, Flutter, Sci-kit Learn, React.js, Node.js, Express.js, ASP.net, Unreal Engine, MySQL',
  ];

  final aboutMeBuffer = StringBuffer();

  final skillsBuffer = StringBuffer();

  // todo write links to github repos
  final workBuffer = StringBuffer();

  // todo write contact infos
  final contactMeBuffer = StringBuffer();

  /// initialize the buffer.
  /// Note that this method
  /// clears out any contents
  /// previously inside.
  void fillBufferFromList(StringBuffer b, List<String> l) {
    if (b.isNotEmpty) {
      b.clear();
    }

    b.writeAll(l);
  }

  ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(()
    {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary from app to app.
      scrollController.position.moveTo(dragUpdate.globalPosition.dy * 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    fillBufferFromList(aboutMeBuffer, aboutMe);
    fillBufferFromList(skillsBuffer, skills);

    List<Widget> navButtons() => [
          NavButton(
            text: 'About',
            textColor: Colors.black,
            onPressed: () {
              showPopup(context,
                  widget: PopupBody(
                    body: SelectableText(
                      aboutMeBuffer.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  title: 'About Me');
            },
          ),
          NavButton(
            text: 'Skills',
            textColor: Colors.black,
            onPressed: () {
              showPopup(context,
                  widget: PopupBody(
                    body: SelectableText(
                      skillsBuffer.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  title: 'About Me');
            },
          ),
          NavButton(
            text: 'Work',
            textColor: Colors.black,
            onPressed: () {
              showPopup(context,
                  widget: PopupBody(
                    body: Column(
                      children: <Widget>[
                        Tooltip(
                          message: 'Top down 2D stealth game',
                          child: RaisedButton(
                            onPressed: () {
                              html.window.open(
                                  'https://wayneheucf.itch.io/desperate-escape',
                                  'project1');
                            },
                            color: Colors.grey,
                            textColor: Colors.white,
                            child: Center(
                              child: Text('Check out my game'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Tooltip(
                          message:
                              'Upload either red apples or tomatoes and watch my model accurately identify between the two. I recommend using file mode once you\'re in the link',
                          child: RaisedButton(
                            onPressed: () {
                              html.window.open(
                                  'https://teachablemachine.withgoogle.com/models/ar89v4khJ/',
                                  'trainedModel');
                            },
                            color: Colors.grey,
                            textColor: Colors.white,
                            child: Center(
                              child: Text('Check out my trained model Here'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: 'Projects');
            },
          ),
          NavButton(
            text: 'Contact',
            textColor: Colors.black,
            onPressed: () {
              showPopup(context,
                  widget: PopupBody(
                    body: RaisedButton(
                      onPressed: () {
                        html.window.open(
                            'https://docs.google.com/document/d/1XaCsdJll_MzHbDgpJ9rPOyZim39uR_T9cu8FvM_-QbY/edit',
                            'contact');
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Center(
                        child: Text(
                            'Please click me to for my contact information'),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),
                  ),
                  title: 'Contact');
            },
          ),
        ];

    return ResponsiveWidget(
      largeScreen: Scaffold(
        backgroundColor: Colors.black,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? AppBar(
                elevation: 0.0,
                backgroundColor: Colors.black,
              )
            : null,
        drawer: ResponsiveWidget.isSmallScreen(context)
            ? Drawer(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: navButtons(),
                ),
              )
            : null,
        body: SingleChildScrollView(
          // only scrolling is allowed
          // physics: NeverScrollableScrollPhysics(),
          controller: scrollController,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/YellowStoneNationaParkPhoto.jpg'),
                  fit: BoxFit.cover),
            ),
            child: AnimatedPadding(
              duration: Duration(seconds: 1),
              padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.1),
              child: ResponsiveWidget(
                largeScreen: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    NavHeader(navButtons: navButtons()),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    //   child: ButtonAnimationImplementation(
                    //     buttonText:
                    //         "Remember to replace navbuttons with this button type",
                    //     // delayeAni: 2000,
                    //     onTap: () {
                    //       ButtonAnimation.disableButton
                    //           ? print("Disable true")
                    //           : print("I'm pressed");
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    ProfileInfo(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SocialInfo(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavHeader extends StatelessWidget {
  final List<Widget> navButtons;

  const NavHeader({Key key, this.navButtons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Row(
        mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // PKDot(),
          Spacer(),
          if (!ResponsiveWidget.isSmallScreen(context))
            Row(
              children: navButtons,
            )
        ],
      ),
    );
  }
}

class PKDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          'Leo',
          textScaleFactor: 2,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

class NavButton extends StatelessWidget {
  final text;
  final onPressed;
  final Color color, textColor;

  const NavButton(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.color = Colors.deepOrangeAccent,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      color: color,
      onPressed: onPressed,
    );
  }
}

class ProfileInfo extends StatelessWidget {
  Container profileImage(context) => Container(
        height: ResponsiveWidget.isSmallScreen(context)
            ? MediaQuery.of(context).size.height * 0.25
            : MediaQuery.of(context).size.width * 0.25,
        width: ResponsiveWidget.isSmallScreen(context)
            ? MediaQuery.of(context).size.height * 0.25
            : MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          // backgroundBlendMode: BlendMode.clear,
          // color: Colors.greenAccent,
//            borderRadius: BorderRadius.circular(40),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/Leo_Magic_Kingdom.jpg'),
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
      );

  Column profileData(BuildContext context) => Column(
        crossAxisAlignment: ResponsiveWidget.isSmallScreen(context) || ResponsiveWidget.isMediumScreen(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: <Widget>[
          SelectableText(
            'Hi there! My name is',
            textScaleFactor: 2,
            style: TextStyle(color: Colors.orange),
          ),
          SelectableText(
            'Leo\nZhang',
            textScaleFactor: 5,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SelectableText(
            'I am currently seeking a part-time job/internship for anything\n'
            'related to programming and problem solving.',
            textScaleFactor: 1.5,
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                shape: StadiumBorder(),
                child: Text('Résumé'),
                color: Colors.cyan,
                onPressed: () {
                  html.window.open(
                      'https://drive.google.com/file/d/1Io3FgZxBUUrbXZKwPpBmMyWlrVafGCrr/view?usp=sharing',
                      'resume');
                },
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                width: 20,
              ),
              OutlineButton(
                borderSide: BorderSide(
                  color: Colors.cyanAccent,
                ),
                shape: StadiumBorder(),
                child: Text('Say Hi!'),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('My Email:'),
                        content: SelectableText(
                            'leoucfstudent@knights.ucf.edu\nor\nleo1997.work@gmail.com'),
                        actions: <Widget>[
                          FlatButton(
                            textColor: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                padding: EdgeInsets.all(10),
              )
            ],
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[profileImage(context), profileData(context)],
      ),
      smallScreen: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          profileImage(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          profileData(context)
        ],
      ),
    );
  }
}

class SocialInfo extends StatelessWidget {
  List<Widget> socialMediaWidgets() => <Widget>[
        NavButton(
          text: 'Github',
          onPressed: () {
            html.window.open('https://github.com/leozhang1', 'Git');
          },
          color: Colors.blue,
        ),
        NavButton(
          text: 'LinkedIn',
          onPressed: () {
            html.window
                .open('https://www.linkedin.com/in/leo-zhang2020/', 'LinkedIn');
          },
          color: Colors.blue,
        ),
        NavButton(
          text: 'Facebook',
          onPressed: () {
            html.window.open('https://www.facebook.com/leo.zhang.31105/', 'Fb');
          },
          color: Colors.blue,
        ),
      ];

  Widget copyRightText() => Text(
        'Leo Zhang ©️2021',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: socialMediaWidgets(),
          ),
          copyRightText(),
        ],
      ),
      smallScreen: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...socialMediaWidgets(),
          copyRightText(),
        ],
      ),
    );
  }
}
