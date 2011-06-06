package onomatopen.painter
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public class TenPainter extends IntervalPainter
	{
		public function TenPainter(points:Array=null)
		{
			super(points);
		}
		
		public override function onDrag(point:Point):void {
			checkInterval(point, 15);
		}
		
		protected override function onInterval(point:Point):void {
			var g:Graphics = this.graphics;
			g.lineStyle(0, 0x000000, 0);
			g.beginFill(0xFF0000);
			g.drawCircle(point.x, point.y, 4);
			g.endFill();
		}
	}
}