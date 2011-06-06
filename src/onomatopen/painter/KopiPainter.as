package onomatopen.painter
{
	import flash.geom.Point;
	
	public class KopiPainter extends Painter
	{
		private var firstPoint:Point;
		
		public function KopiPainter(points:Array=null)
		{
			super(points);
			if (points && points[0]) {
				firstPoint = points[0];
			}
		}
		
		public override function onMouseDown(point:Point):void {
			if (!firstPoint) {
				firstPoint = point;
			}
			graphics.beginFill(0x6666FF, 0.2);
			graphics.lineStyle(1, 0x6666FF);
			graphics.moveTo(point.x, point.y);
		}
		
		public override function onDrag(point:Point):void {
			graphics.lineTo(point.x, point.y);
		}
		
		public override function onMouseUp(point:Point):void {
			graphics.lineTo(point.x, point.y);
			if (firstPoint) {
				graphics.lineTo(firstPoint.x, firstPoint.y);
			}
			graphics.endFill();
		}
	}
}