package onomatopen.painter
{
	import flash.display.Graphics;
	import flash.geom.Point;

	public class NormalPainter extends Painter
	{
		public function NormalPainter(points:Array = null)
		{
			super(points);
		}
		
		public override function onMouseDown(point:Point):void {
			graphics.lineStyle(2, 0x999999);
			graphics.moveTo(point.x, point.y);
		}
		
		public override function onDrag(point:Point):void {
			graphics.lineTo(point.x, point.y);
		}
		
		public override function onMouseUp(point:Point):void {
			graphics.lineTo(point.x, point.y);
		}
	}
}
