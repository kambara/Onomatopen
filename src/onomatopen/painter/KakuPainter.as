package onomatopen.painter
{
	import flash.geom.Point;
	
	public class KakuPainter extends Painter
	{
		private var prevDot:Point;
		private var vertexIsA:Boolean = true;
		
		public function KakuPainter(points:Array=null)
		{
			super(points);
			this.graphics.lineStyle(2, 0x000000);
		}
		
		public override function onMouseDown(point:Point):void {
			graphics.lineStyle(2, 0x000000);
			graphics.moveTo(point.x, point.y);
			prevDot = point;
			
		}
		
		public override function onDrag(point:Point):void {
			drawKakuLineTo(point);
		}
		
		public override function onMouseUp(point:Point):void {
			//graphics.lineTo(point.x, point.y);
		}
		
		private function drawKakuLineTo(point:Point):void {
			var interval:uint = 15;
			var amplitude:uint = 7; // ギザギザの振幅/2
			var dist:Number = Point.distance(point, prevDot);
			if (dist >= interval) {
				// 長すぎる線を分割
				var vector:Point = point.subtract(prevDot);
				var verticalVectorA:Point = rotate90AndScale(vector, amplitude/dist);
				var verticalVectorB:Point = invert(verticalVectorA);
				var lastD:Point = prevDot;
				var n:uint = Math.floor(dist/interval); // 描画するポイント(頂点)数
				for (var i:int=1; i<=n; i++) {
					// 点線と頂点の垂線が直行する点
					var scale:Number = i*interval/dist; // 縮小率
					var dx:Number = vector.x * scale;
					var dy:Number = vector.y * scale;
					var dot:Point = prevDot.add(new Point(dx, dy));
					// dotから垂直のとこに頂点
					var vertex1:Point = vertexIsA
											? lastD.add(verticalVectorA)
											: lastD.add(verticalVectorB);
					var vertex2:Point = vertexIsA
											? dot.add(verticalVectorA)
											: dot.add(verticalVectorB);
					lastD = dot;
					vertexIsA = !vertexIsA;
					// 頂点を結ぶ
					graphics.lineTo(vertex1.x, vertex1.y);
					graphics.lineTo(vertex2.x, vertex2.y);
				}
				if (lastD) prevDot = lastD;
			}
		}
		
		private function rotate90AndScale(point:Point, scale:Number):Point {
			return new Point(-point.y * scale, point.x * scale); 
		}
		
		private function invert(point:Point):Point {
			return new Point(-point.x, -point.y);
		}
	}
}