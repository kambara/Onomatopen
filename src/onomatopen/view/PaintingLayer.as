package onomatopen.view
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import onomatopen.BrushChoicer;
	import onomatopen.painter.ChokiPainter;
	import onomatopen.painter.GizaPainter;
	import onomatopen.painter.KakuPainter;
	import onomatopen.painter.KeshiPainter;
	import onomatopen.painter.KiraPainter;
	import onomatopen.painter.MokoPainter;
	import onomatopen.painter.NormalPainter;
	import onomatopen.painter.Painter;
	import onomatopen.painter.TenPainter;

	//
	// Obsolete!!!!
	//
	public class PaintingLayer extends UIComponent
	{
		private var dragging:Boolean = false;
		private var points:Array = [];
		private var brushChoicer:BrushChoicer;
		private var currentPainter:Painter;
		private var painted:Shape;
		
		public function PaintingLayer(/*choicer:BrushChoicer*/)
		{
			super();
			
			painted = new Shape();
			addChild(painted);
			
			switchPainterTo(new NormalPainter());
			
			/****
			brushChoicer = choicer;
			brushChoicer.addEventListener("change", onBrushChange); // ペンのテストの時は消すと良い。onMouseDownでデフォルト。
			*/
			addEventListener(Event.ADDED_TO_STAGE, function():void {
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			});
		}
		
		public function clear():void {
			painted.graphics.clear();
		}
		
		/*
		//
		// ブラシ変更イベント
		//
		private function onBrushChange(event:Event):void {
			switch(brushChoicer.currentBrush) {
				case "kaku":
					switchPainterTo(new KakuPainter(points));
					break;
				case "kira":
					switchPainterTo(new KiraPainter(points));
					break;
				case "moko":
					switchPainterTo(new MokoPainter(points));
					break;
				case "giza":
					switchPainterTo(new GizaPainter(points));
					break;
				case "ten":
					switchPainterTo(new TenPainter(points));
					break;
				case "keshi":
					switchPainterTo(new KeshiPainter(points));
					break;
				case "choki":
					switchPainterTo(new ChokiPainter(points));
					break;
				default:
					switchPainterTo(new NormalPainter(points));
					break;
			}
			
			if (brushChoicer.currentBrush == "keshi") {
				this.blendMode = BlendMode.LAYER;
				currentPainter.blendMode = BlendMode.ERASE;
			} else {
				this.blendMode = BlendMode.NORMAL;
				currentPainter.blendMode = BlendMode.NORMAL;
			}
		}
		
		private function switchPainterTo(newPainter:Painter):void {
			// todo: ドラッグしていないときでもswitchしてしまう件
			removePainter();
			currentPainter = newPainter;
			addChild(currentPainter);
		}
		
		private function removePainter():void {
			if (currentPainter) {
				removeChild(currentPainter);
				currentPainter = null;
			}
		}
		*/
		
		/*
		//
		// マウス
		//
		private function onMouseDown(mouse:MouseEvent):void {
			brushChoicer.reset();
			switchPainterTo(new NormalPainter());
			//switchPainterTo(new KakuPainter()); // ペンのテスト用
			points = [];
			
			var point:Point = addPoint(mouse.localX, mouse.localY);
			currentPainter.onMouseDown(point);
			dragging = true;
		}
		
		private function onMouseMove(mouse:MouseEvent):void {
			if (!dragging) return;
			var point:Point = addPoint(mouse.localX, mouse.localY);
			currentPainter.onDrag(point);
		}
		
		private function onMouseUp(mouse:MouseEvent):void {
			dragging = false;
			var point:Point = addPoint(mouse.localX, mouse.localY);
			currentPainter.onMouseUp(point);
			
			if (brushChoicer.currentBrush == "choki") {
				// cut
				
			} else {
				blendToPainted();
			}
			
			// 線を消す
			removePainter();
			points = [];
			
			// ブラシリセット
			brushChoicer.reset();
			switchPainterTo(new NormalPainter());
		}
		
		private function cut():void {
			
		}
		
		private function blendToPainted():void {
			var rect:Rectangle = this.getBounds(this);
			if (!rect.right || !rect.bottom) return;
			
			var bmd:BitmapData = new BitmapData(rect.right, rect.bottom, true, 0x00FFFFFF);
			bmd.draw(this);
			updatePainted(bmd);
		}
		
		private function updatePainted(bmd:BitmapData):void {
			var g:Graphics = this.painted.graphics;
			g.clear();
			g.beginBitmapFill(bmd);
			g.moveTo(0, 0);
			g.lineTo(bmd.width, 0);
			g.lineTo(bmd.width, bmd.height);
			g.lineTo(0, bmd.height);
			g.lineTo(0, 0);
			g.endFill();
		}
		
		//
		// 通過点を記録しておく
		//
		private function addPoint(x:int, y:int):Point {
			var p:Point = new Point(x, y);
			this.points.push(p);
			return p;
		}
		*/
	}
}