package onomatopen.painter
{
	import flash.display.BlendMode;
	import flash.geom.Point;
	
	public class KeshiPainter extends Painter
	{
		public function KeshiPainter(points:Array=null)
		{
			super(points);
			this.blendMode = BlendMode.ERASE;
		}
		
		public override function onMouseDown(point:Point):void {
			graphics.lineStyle(25, 0x000000);
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