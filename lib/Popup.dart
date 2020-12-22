import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Popup_content.dart';

class PopupLayout extends ModalRoute
{
  // define some variables for dynamic update the margin and content
  double top, bottom, left, right;
  Color bgColor;
  final Widget child;

  PopupLayout(
      {Key key,
      this.bgColor,
      @required this.child,
      this.top,
      this.bottom,
      this.left,
      this.right});

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => bgColor ?? Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => false;

  @override
  Widget buildPage(BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,)
  {

    top = top ?? 10;
    bottom = bottom ?? 20;
    left = left ?? 20;
    right = right ?? 20;

    // if (top == null) this.top = 10;
    // if (bottom == null) this.bottom = 20;
    // if (left == null) this.left = 20;
    // if (right == null) this.right = 20;

    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Material(
        // This makes sure that text and other content follows the material style
        type: MaterialType.transparency,
        //type: MaterialType.canvas,
        // make sure that the overlay content is not cut off
        child: SafeArea(
          bottom: true,
          child: _buildOverlayContent(context),
        ),
      ),
    );
  }

  //the dynamic content pass by parameter
  Widget _buildOverlayContent(BuildContext context)
  {
    return Container(
      margin: EdgeInsets.only(
          bottom: this.bottom,
          left: this.left,
          right: this.right,
          top: this.top),
      child: child,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child)
  {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

Widget PopupBody({Widget body = const Text('body text'),
EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),})
{
  return SingleChildScrollView(
    child: Padding(
      padding: padding,
      child: body
    ),
  );
}

// call this method in the button on pressed function body
void showPopup(BuildContext context, {Widget widget, String title})
{
  Navigator.push(
    context,
    PopupLayout(
      top: 30,
      left: 30,
      right: 30,
      bottom: 50,
      child: PopupContent(
        content: Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: Builder(builder: (context)
            {
              return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: ()
                {
                  try
                  {
                    //close the popup
                    Navigator.pop(context);
                  }
                  catch (e)
                  {
                    print(e);
                  }
                },
              );
            }),
            brightness: Brightness.light,
          ),
          resizeToAvoidBottomPadding: false,

          // will be the popup body
          body: SafeArea(child: widget),
        ),
      ),
    ),
  );
}
