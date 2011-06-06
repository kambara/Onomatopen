package onomatopen.painter
{
	import flash.geom.Point;
	
	public class ChokiPainter extends Painter
	{
		private var firstPoint:Point;
		
		public function ChokiPainter(points:Array=null)
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
			graphics.beginFill(0xFF6666, 0.2);
			graphics.lineStyle(1, 0xFF6666);
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