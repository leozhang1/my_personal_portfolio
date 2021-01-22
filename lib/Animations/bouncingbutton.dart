import 'package:flutter/material.dart';
import 'package:my_personal_portfolio/Colors/appThemeColors.dart';
import 'bouncing_button_animation.dart';


class ButtonAnimationImplementation extends StatefulWidget
{
  final int delayAnimationTime;
  final String buttonText;
  final Function onTap;

  const ButtonAnimationImplementation(
      {Key key, this.delayAnimationTime, this.buttonText, this.onTap}):super(key:key);
  @override
  _ButtonAnimationImplementationState createState() =>
      _ButtonAnimationImplementationState();
}

class _ButtonAnimationImplementationState
    extends State < ButtonAnimationImplementation >
{
  bool isPressed = false;
  double _scale = 0.986;

  void onPressedUp(PointerUpEvent event)
    {
    setState(()
        {
      isPressed = false;
    });
  }

  void onPressedDown(PointerDownEvent event)
    {
    setState(()
        {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context)
    {
    return ButtonAnimation(
      delayTime:widget.delayAnimationTime,
      child:GestureDetector(
        onTap:widget.onTap,
        child:Listener(
          onPointerUp:onPressedUp,
          onPointerDown:onPressedDown,
          child:isPressed?Transform.scale(
                  scale:_scale,
                  child:Container(
                    width:88,
                    height:36,
                    decoration:BoxDecoration(
                      boxShadow:[
                        BoxShadow(
                          color:Colors.black26,
                          blurRadius:3.0,
                          offset:Offset(0, 4),
                        ),
                      ],
                      color:AppThemeColors.materialTheme,
                      borderRadius:BorderRadius.all(Radius.circular(2.5)),
                    ),
                    child:Center(
                      child:Text(
                        widget.buttonText,
                        textAlign:TextAlign.center,
                        maxLines:3,
                        overflow:TextOverflow.ellipsis,
                        style:TextStyle(
                          color:AppThemeColors.themeAccent,
                          fontWeight:FontWeight.bold,
                          letterSpacing:1.2,
                          fontSize:10,
                        ),
                      ),
                    ),
                  ),
                ):Container(
                  width:88,
                  height:36,
                  decoration:BoxDecoration(
                    boxShadow:[
                      BoxShadow(
                        color:Colors.black26,
                        blurRadius:5.0,
                        offset:Offset(0, 10),
                      ),
                    ],
                    color:AppThemeColors.materialTheme,
                    borderRadius:BorderRadius.all(Radius.circular(2.5)),
                  ),
                  child:Center(
                    child:Text(
                      widget.buttonText,
                      textAlign:TextAlign.center,
                      maxLines:3,
                      overflow:TextOverflow.ellipsis,
                      style:TextStyle(
                        color:AppThemeColors.themeAccent,
                        fontWeight:FontWeight.bold,
                        letterSpacing:1.2,
                        fontSize:10.0,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
