package
{
	
	//	import com.greensock.plugins.GlowFilterPlugin;
	//	import com.greensock.plugins.TweenPlugin;
	//	
	//	import flash.crypto.generateRandomBytes;
	//	import flash.display.Bitmap;
	//	import flash.display.BitmapData;
	//	import flash.display.BlendMode;
	//	import flash.display.DisplayObject;
	//	import flash.display.GradientType;
	//	import flash.display.Graphics;
	//	import flash.display.Loader;
	//	import flash.display.Shape;
	//	import flash.display.SpreadMethod;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.GraphicsTrianglePath;
	import flash.display.Loader;
	import flash.display.PNGEncoderOptions;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Worker;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.getTimer;
	
	import pixel.assets.PixelAssetTask;
	import pixel.assets.PixelAssetsManager;
	import pixel.assets.event.PixelAssetEvent;
	import pixel.core.PixelConfig;
	import pixel.core.PixelLauncher;
	import pixel.particle.PixelParticlePropertie;
	import pixel.ui.control.HorizontalScroller;
	import pixel.ui.control.LayoutConstant;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIPanel;
	import pixel.ui.control.UIProgress;
	import pixel.ui.control.VerticalPanel;
	import pixel.ui.control.VerticalScroller;
	import pixel.ui.control.style.VerticalScrollerStyle;
	import pixel.utility.ColorCode;
	import pixel.utility.RGBA;
	import pixel.utility.Stat;
	import pixel.utility.System;
	import pixel.utility.Tools;
	import pixel.utility.loader.Loader;
	import pixel.utility.swf.Swf;
	import pixel.utility.swf.SwfFactory;
	import pixel.worker.core.PixelWorker;
	import pixel.worker.core.PixelWorkerHelper;
	import pixel.worker.core.ShareMemory;
	import pixel.worker.event.PixelWorkerEvent;
	import pixel.worker.message.PixelWorkerLoaderMessageResponse;
	import pixel.worker.message.PixelWorkerMessage;
	import pixel.worker.message.PixelWorkerMessageRequest;
	import pixel.worker.message.PixelWorkerMessageResponse;
	
	import ui.aa;
	
	//	import flash.display.StageAlign;
	//	import flash.display.StageScaleMode;
	//	import flash.events.Event;
	//	import flash.events.KeyboardEvent;
	//	import flash.events.MouseEvent;
	//	import flash.filesystem.File;
	//	import flash.filesystem.FileMode;
	//	import flash.filesystem.FileStream;
	//	import flash.geom.Matrix;
	//	import flash.geom.Point;
	//	import flash.geom.Rectangle;
	//	import flash.net.URLLoader;
	//	import flash.net.URLLoaderDataFormat;
	//	import flash.net.URLRequest;
	//	import flash.system.ApplicationDomain;
	//	import flash.system.LoaderContext;
	//	import flash.system.MessageChannel;
	//	import flash.system.Security;
	//	import flash.system.SecurityDomain;
	//	import flash.system.Worker;
	//	import flash.system.WorkerDomain;
	//	import flash.text.TextField;
	//	import flash.text.TextFieldType;
	//	import flash.text.engine.ContentElement;
	//	import flash.text.engine.ElementFormat;
	//	import flash.text.engine.GroupElement;
	//	import flash.text.engine.TextBlock;
	//	import flash.text.engine.TextElement;
	//	import flash.text.engine.TextLine;
	//	import flash.ui.Keyboard;
	//	import flash.utils.ByteArray;
	//	import flash.utils.CompressionAlgorithm;
	//	import flash.utils.Dictionary;
	//	import flash.utils.getTimer;
	//	
	//	import editor.uitility.ui.ActiveFrame;
	//	
	//	import game.sdk.error.GameError;
	//	import game.sdk.event.GameEvent;
	//	import game.sdk.map.layer.DiamondLayer;
	//	import game.sdk.map.layer.GenericLayer;
	//	import game.sdk.map.terrain.TerrainData;
	//	import game.sdk.spr.SpriteManager;
	//	import game.sdk.spr.SpriteSheet;
	//	
	//	import pixel.core.PixelLauncher;
	//	import pixel.ui.control.IUIControl;
	//	import pixel.ui.control.UIButton;
	//	import pixel.worker.core.PixelWorker;
	//	import pixel.worker.core.PixelWorkerGeneric;
	//	import pixel.worker.core.PixelWorkerHelper;
	//	import pixel.worker.event.PixelWorkerEvent;
	//	
	//	import utility.BitmapTools;
	//	import utility.ColorCode;
	//	import utility.RGBA;
	//	import utility.Tools;
	//	import utility.bitmap.png.PNGDecoder;
	//	import utility.bitmap.tga.TGADecoder;
	[SWF(width="1280",height="600",frameRate="30")]
	public class Sample extends Sprite
	{
		[Embed(source="../bin-debug/TestWorker.swf",mimeType="application/octet-stream")]
		private var workerClass:Class;
		private var sid:String = "";
		private var center:Point = new Point();
		public function Sample()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			//rotateTest();
			center.x = stage.stageWidth / 2;
			center.y = stage.stageHeight / 2;
			
			emitter();
			
			var s:Stat = new Stat();
			addChild(s);
		}
		
		private function angleGetTest():void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE,function(event:MouseEvent):void{
				
				var angle:Number = Math.atan2(event.stageY - center.y,event.stageX - center.x);
				
				trace((angle * 180 / Math.PI));
			});
		}
		
		private var fun:Function = function(n:String):void{
			trace(this);
			Ctx(this).sid = n;
			//this.sid = n;
		};
		
		private function proxyTest():void
		{
			var a:Ctx = new Ctx();
			var b:Ctx = new Ctx();
			fun.call(b,["aaaa"]);
			trace(b.sid);
		}
		
		
		private function curveTest():void
		{
			var draw:Graphics = this.graphics;
			draw.clear();
			draw.lineStyle(1,0,1,false,"normal",CapsStyle.ROUND);
			draw.drawRoundRect(100,100,100,100,8,8);
		}
		
		private var queue:Vector.<Particle> = new Vector.<Particle>();
		private var ball:Particle; 
		private var angle:Number = 0; 
		private var radiusX:Number = 150; 
		private var radiusY:Number = 100;
		private var vr:Number = .1;
		private function rotateTest():void
		{
			var ball:Particle = new Particle();
			addChild(ball);
			
			ball.x = stage.stageWidth / 2; 
			ball.y = stage.stageHeight / 2;
			
			var ballang:Number = 0;
			
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
				ball.x = stage.stageWidth / 2 + Math.cos(angle) * radiusX ; 
				ball.y = stage.stageHeight / 2 + Math.sin(angle) * radiusY; 
				angle += vr;
				//				var ang:Number = Math.cos(angle);
				//				ball.x = stage.stageHeight / 2 + ang * 100; 
				//				angle += .3;
				//				ball.y -= 3;
			});
		}
		
		private function waveTest():void
		{
			//			var ball:Particle = new Particle();
			//			addChild(ball);
			//			var ball2:Particle = new Particle();
			//			addChild(ball2);
			//			
			//			ball.x = stage.stageWidth / 2; 
			//			ball.y = stage.stageHeight / 2;
			//			
			//			ball2.x = ball.x;
			//			ball2.y = ball.y;
			//			
			//			var ang:Number = 0;
			//			var v:Number = 1;
			//			var v2:Number = -1;
			
			//			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
			//				var ang:Number = Math.cos(angle);
			//				ball.x = stage.stageHeight / 2 + ang * v * 100;
			//				ball2.x = stage.stageHeight / 2 + ang * v2 * 100;
			//				angle += .3;
			//				ball.y -= 1;
			//				ball2.y -= 1;
			//			});
			
			var ang:Number = 0;
			var v:Number = 1;
			
			//			for(var i:int = 0; i< 20; i++)
			//			{
			//				ball = new Particle();
			//				ball.x = stage.stageWidth / 2; 
			//				ball.y = stage.stageHeight / 2;
			//				queue.push(ball);
			//				addChild(ball);
			//			}
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
				//var ang:Number = Math.cos(angle);
				for each(var node:Particle in queue)
				{
					var nm:int = Math.random() * 100;
					v *= nm > 50 ? -1:1;
					ang = Math.cos(node.angle);
					node.x = stage.stageHeight / 2 + ang * v * 100;
					node.y -= Math.random() * 5;
					//v *= -1;
					node.angle += 0.2;
				}
				
				angle += .3;
			});
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK,function(event:Event):void{
				
				for(var idx:int = 0; idx< 10; idx++)
				{
					ball = new Particle();
					ball.x = stage.stageWidth / 2; 
					ball.y = stage.stageHeight / 2;
					queue.push(ball);
					addChild(ball);
				}
				
			});
		}

		private function emitter():void
		{
			var propertie:PixelParticlePropertie = new PixelParticlePropertie();
			propertie.attenuation = 1;
			propertie.health = 100;
			propertie.maxmizeParticle = 100;
			propertie.particleCount = 30;
			propertie.poolable = true;
			propertie.size = 2;
			propertie.velocityX = 5;
			propertie.velocityY = 5;
			
			var emitter:Emitter = new Emitter(propertie);
			emitter.x = center.x;
			emitter.y = center.y;
			addChild(emitter);
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
				emitter.update();			
			});
		}
		
		private function rotateE():void
		{
			//			var ball:Particle = new Particle();
			var pos:Point = new Point(stage.stageWidth / 2,stage.stageHeight / 2);
			//ball.x = pos.x;
			//ball.y = pos.y;
			var angle:Number = 0;
			var radiusX:int = 100;
			var radiusY:int = 50;
			var blur:BlurFilter = new BlurFilter(5,5,1);
			//stage.addChild(ball);
			var canvas:BitmapData = new BitmapData(stage.stageWidth,stage.stageHeight);
			var image:Bitmap = new Bitmap(canvas);
			//addChild(image);
			
			var mask:BitmapData = new BitmapData(stage.stageWidth,stage.stageHeight,true,0x00FFFFFF);
			var m:Bitmap = new Bitmap(mask);
			//addChild(m);
			var tran:ColorTransform = new ColorTransform(1,1,1,0.9);
			var mtx:Matrix = new Matrix();

			var batch:Vector.<Particle> = new Vector.<Particle>();
			var radiusXseek:int = 1;
			var radiusYseek:int = 1;
			var seek:Number = 1;
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
				var t:int = flash.utils.getTimer();
				var node:Particle = null;
				
				//				if(batch.length < queue.length)
				//				{
				//					while(true)
				//					{
				//						node = queue.shift();
				//						t = flash.utils.getTimer();
				//						node.x = pos.x + Math.cos(node.angle) * radiusX;
				//						node.y = pos.y + Math.sin(node.angle) * radiusY;
				//						trace("math[" + (flash.utils.getTimer() - t) + "]");
				//						mtx.tx = node.x;
				//						mtx.ty = node.y;
				//						t = flash.utils.getTimer();
				//						//canvas.applyFilter(canvas,canvas.rect,new Point(),blur);
				//						canvas.colorTransform(canvas.rect,tran);
				//						trace("transform[" + (flash.utils.getTimer() - t) + "]");
				//						t = flash.utils.getTimer();
				//						canvas.draw(node,mtx);
				//						trace("draw[" + (flash.utils.getTimer() - t) + "]");
				//						node.angle += 0.1;
				//						seek++;
				//						batch.push(node);
				//						if(seek >= 100)
				//						{
				//							seek = 0;
				//							return;
				//						}
				//					}
				//					
				//					
				//				}
				//				else
				//				{
				//					queue = batch;
				//					batch = new Vector.<Particle>();
				//				}
				
				
				for each(node in queue)
				{
					node.x = pos.x + Math.cos(node.angle) * (radiusX);
					node.y = pos.y + Math.sin(node.angle) * (radiusY);
					radiusXseek += seek;
					radiusYseek += seek;
					pos.y-= 3;
					
					//mtx.tx = node.x;
					//mtx.ty = node.y;

					//canvas.applyFilter(canvas,canvas.rect,new Point(),blur);
					//canvas.colorTransform(canvas.rect,tran);

					node.angle += 0.4;
					
				}
				
				//trace(queue.length + "");
			});
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK,function(event:Event):void{
				
				for(var i:int = 0; i< 1; i++)
				{
					ball = new Particle(int(Math.random() * 10));
					ball.angle = Math.random() * 100;
					queue.push(ball);
					stage.addChild(ball);
				}
				
			});
		}
		
		[Embed(source="../bin-debug/assets/img.png")]
		private var Img:Class;
		private function bitmap555():void
		{
			var img:Bitmap = new Img() as Bitmap;
			var orgin:BitmapData = img.bitmapData;
			var small:BitmapData = new BitmapData(img.width,img.height);
			//var fff:BitmapData = new BitmapData(img.width,img.height);
			for(var i:int=0; i<img.height; i++)
			{
				for(var j:int=0; j<img.width; j++)
				{
					var pixel:uint = orgin.getPixel(j,i);
					//pixel = ColorCode.RGB888ToRGB565(pixel);
					//var fix:uint = ColorCode.RGB565ToRGB888(pixel,false).Pixel;
					//pixel = ColorCode.RGB565ToRGB888(pixel,false).Pixel;
					
					//pixel = ColorCode.RGB4444ToRGB8888(,false).Pixel;
					var rgba:RGBA = ColorCode.RGB8888ToRGB4444(pixel);
					small.setPixel(j,i,rgba.Pixel);
					//fff.setPixel(j,i,fix);
				}
			}
			
			var image:Bitmap = new Bitmap(small);
			addChild(image);
			
			img.x = img.width;
			addChild(img);
			
			
			var a:PNGEncoderOptions = new PNGEncoderOptions();
			
			var data:ByteArray = small.encode(small.rect,a);
			
			var writer:FileStream = new FileStream();
			var file:File = new File("D:\\4444.png");
			writer.open(file,FileMode.WRITE);
			writer.writeBytes(data,0,data.length);
			writer.close();
		}
		
		private function readswf():void
		{
			//var data:ByteArray = new C() as ByteArray;
			//var swf:Swf = SwfFactory.Instance.Decode(data);
			
		}
		
		private function workerTest():void
		{
			
			PixelWorkerHelper.instance.createWorkerByURL("TestWorker.swf");
			PixelWorkerHelper.instance.addEventListener(PixelWorkerEvent.WORKER_COMPLETE,function(event:PixelWorkerEvent):void{
				var work:PixelWorker = event.message as PixelWorker;
				work.addEventListener(PixelWorkerEvent.MESSAGE_AVAILABLE,function(event:PixelWorkerEvent):void{
					var msg:PixelWorkerLoaderMessageResponse = event.message as PixelWorkerLoaderMessageResponse;
					
					if(msg.shareMemory)
					{
						var memory:ByteArray = work.getShareProperty(ShareMemory.SHARE_BYTEARRAY) as ByteArray;
						var a:flash.display.Loader = new flash.display.Loader();
						var ctx:LoaderContext = new LoaderContext();
						ctx.applicationDomain = ApplicationDomain.currentDomain;
						ctx.allowCodeImport = true;
						a.loadBytes(memory,ctx);
						a.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
							var vec:Vector.<String> = a.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames();
							trace(vec.length + "");
						});
					}
				});
				work.start();
				
				stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
					var req:PixelWorkerMessageRequest = new PixelWorkerMessageRequest(PixelWorkerMessage.LOAD_SWF);
					req.message = "http://175.10.1.144:9200/payplateform/UI.swf";
					work.sendMessage(req);
				});
			});
		}
	}
}

class Ctx
{
	public var sid:String = "";
}

import flash.display.Sprite;
import flash.filters.BlurFilter;
import flash.filters.GlowFilter;
import flash.geom.Point;

class Particle extends Sprite
{
	public var angle:Number = 0;
	public var health:Number = 100;
	public var velocityX:int = 5;
	public var velocityY:int = 5;
	public function Particle(radius:Number = 2)
	{
		this.graphics.beginFill(Math.random() * 0xFFFFFF);
		this.graphics.drawCircle(0,0,radius);
		this.graphics.endFill();
		
		var glow:GlowFilter = new GlowFilter(0x00FF00,0.5);
		var blur:BlurFilter = new BlurFilter(5,5,1);
		this.filters = [blur];
	}
}