package onomatopen.painter
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class KiraPainter extends IntervalPainter
	{
		[Embed(source="assets/kira1.png")]
		private var Img1:Class;
		[Embed(source="assets/kira2.png")]
		private var Img2:Class;
		[Embed(source="assets/kira3.png")]
		private var Img3:Class;
		[Embed(source="assets/kira4.png")]
		private var Img4:Class;
		[Embed(source="assets/kira5.png")]
		private var Img5:Class;
		[Embed(source="assets/kira6.png")]
		private var Img6:Class;
		
		private var images:Array = [];
		private var classFullName:String = null;
		
		public function KiraPainter(points:Array=null)
		{
			classFullName = getQualifiedClassName(this);
			super(points);
		}
		
		public override function onDrag(point:Point):void {
			checkInterval(point, 45);
		}
		
		public override function onMouseUp(point:Point):void {
			
		}
		
		protected override function onInterval(point:Point):void {
			var i:int = Math.ceil(6 * Math.random()); // 1 ~ 6
			
			var classRef:Class = getDefinitionByName(classFullName + "_Img" + i) as Class;
			var bmp:Bitmap = new classRef();
			bmp.x = point.x - bmp.width/2;
			bmp.y = point.y - bmp.height/2;
			addChild(bmp);
		}
	}
}