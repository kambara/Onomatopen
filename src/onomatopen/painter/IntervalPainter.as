package onomatopen.painter
{
	import flash.geom.Point;
	
	public class IntervalPainter extends Painter
	{
		//
		// 点線タイプ用
		//
		private var prevDot:Point;
		
		public function IntervalPainter(points:Array=null)
		{
			super(points);
		}
		
		public override function onMouseDown(point:Point):void {
			prevDot = point;
		}
		
		public override function onDrag(point:Point):void {
			checkInterval(point, 10);
		}
		
		//
		// ~px間隔を計測
		//
		protected function checkInterval(point:Point, interval:uint):void {
			var dist:Number = Point.distance(point, prevDot);
			if (dist >= interval) {
				// 長すぎる直線は分割して点を描く
				var vector:Point = point.subtract(prevDot);
				var prev:Point;
				var n:uint = Math.floor(dist/interval); // 描画するポイント数
				for (var i:int=1; i<=n; i++) {
					var scale:Number = i*interval/dist;
					var dx:Number = vector.x * scale;
					var dy:Number = vector.y * scale;
					var dot:Point = prevDot.add(new Point(dx, dy));
					prev = dot;
					onInterval(dot);
				}
				if (prev) {
					prevDot = prev;
				}
			}
		}
		
		protected function onInterval(point:Point):void {} // ここに各点の処理を書く
		
	}
}