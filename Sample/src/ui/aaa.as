package ui
{
import corecom.control.*;
 import corecom.control.asset.ControlAssetManager;

 import flash.display.Bitmap;
import flash.display.BitmapData; 
import corecom.control.style.*; 
public class aaa extends corecom.control.UIPanel
{
public var Child_0:UISlider = new UISlider();

public function aaa()
{
addChild(Child_0);
Child_0.x = 226;
Child_0.y = 246;

this.width=500;
this.height=500;
Child_0.width=150;
Child_0.height=40;
Child_0.Style.BackgroundAlpha=0;
Child_0.Style.BorderThinkness=0;
SliderStyle(Child_0.Style).SliderLineHeight = 9;
SliderStyle(Child_0.Style).SliderLineColor = 3355443;

}
}
}
