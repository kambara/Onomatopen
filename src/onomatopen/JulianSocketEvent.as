package onomatopen
{
	import flash.events.Event;

	public class JulianSocketEvent extends Event
	{
		public static var WORD:String = "word";
		
		private var _word:String;
		
		public function JulianSocketEvent(type:String, word:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_word = word;
		}
		
		public function get word():String {
			return this._word;
		}
	}
}