package onomatopen.painter
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.filters.DropShadowFilter;
	import flash.filters.GradientBevelFilter;
	import flash.geom.Point;
	
	public class MokoPainter extends Painter
	{
		private var prevDot:Point;
		private var prevRadius:Number;
		// レイヤー
		private var highlightLayer:Shape;
		private var baseLayer:Shape;
		private var shadeLayer:Shape;
			
		public function MokoPainter(points:Array=null)
		{
			shadeLayer = new Shape();
			baseLayer = new Shape();
			highlightLayer = new Shape();
			addChild(shadeLayer);
			addChild(baseLayer);
			addChild(highlightLayer);
			
			var myFilters:Array = [];
			myFilters.push(new GradientBevelFilter(3, 45, 
				[0x333399, 0x6666FF, 0xDDDDFF],
				[1, 0, 1],
				[0, 128, 255],
				11, 11, // blur
				4, // strength
				2));
			myFilters.push(new DropShadowFilter(
				2, 45,
				0x000000, 0.4, // color, alpha
				2, 2)); // blur
			baseLayer.filters = myFilters;
				
			super(points);
		}
		
		public override function onMouseDown(point:Point):void {
			prevDot = point;
			prevRadius = 8;
		}
		
		public override function onDrag(point:Point):void {
			mokoLineTo(point);
		}
		
		public override function onMouseUp(point:Point):void {
			mokoLineTo(point);
		}
		
		private function mokoLineTo(point:Point):void {
			// 2px置きにモコ点
			var interval:Number = 3;
			var dist:Number = Point.distance(point, prevDot);
			if (dist >= interval) {
				// 線を分割して点を描く
				var vector:Point = point.subtract(prevDot);
				var prev:Point;
				var n:uint = Math.floor(dist/interval); // 直線内に描画するポイント数
				
				var targetRadius:Number = 6 + 3/n;
				var dr:Number = targetRadius - prevRadius;
				
				// 傾きからハイライトの大きさを決める
				/*
				var slope:Number = -vector.y / vector.x;
				var rScale:Number = (-1 < slope && slope < 1)
										? slope * 2/3 + 1/3
										: (slope >= 1)
											? 1/slope
											: 0;
				var highlightRadius:Number = 4 * rScale;
				*/
				
				for (var i:int=1; i<=n; i++) {
					// 描画点
					var scale:Number = i*interval/dist; // 縮小率
					var dot:Point = prevDot.add(new Point(
										vector.x * scale,
										vector.y * scale));
					prev = dot;
					
					// 太さ。スピードで変化。早いほど細い。
					// 急激な変化をしないようにする。
					var r:Number = prevRadius + (targetRadius - prevRadius) * i/n;
					
					this.drawMokoDot(dot, r/*, highlightRadius*/);
				}
				// 次のペン用
				prevRadius = targetRadius;
				if (prev) prevDot = prev;
			}
		}
		private function drawMokoDot(point:Point, r:Number/*, highlightRadius:Number*/):void {
			// 影
			/*
			var g1:Graphics = this.shadeLayer.graphics;
			g1.beginFill(0x444499);
			g1.lineStyle(0, 0x000000, 0);
			g1.drawCircle(point.x + r/3, point.y + r/3, r);
			g1.endFill();
			*/
			
			// ベース
			var g2:Graphics = this.baseLayer.graphics;
			g2.beginFill(0x6666FF);
			g2.drawCircle(point.x, point.y, r);
			g2.endFill();
			
			// ハイライト
			/*
			var g3:Graphics = this.highlightLayer.graphics;
			g3.beginFill(0xFFFFFF, 0.3);
			g3.drawCircle(
				point.x-r+5,
				point.y-r+5,
				highlightRadius);
			g3.endFill();
			*/
		}
	}
}