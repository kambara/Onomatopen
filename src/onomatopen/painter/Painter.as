package onomatopen.painter
{
	import flash.geom.Point;
	
	import mx.core.UIComponent;

	public class Painter extends UIComponent
	{
		public function Painter(points:Array = null)
		{
			super();
			
			// あらかじめ前の線を描いておく
			if (points && points.length > 0) {
				onMouseDown(points[0]);
				if (points.length > 1) {
					for each (var p:Point in points) {
						onDrag(p);
					}
				}
			}
		}
		
		public function onMouseDown(point:Point):void {}
		public function onDrag(point:Point):void {}
		public function onMouseUp(point:Point):void {}
	}
}