package onomatopen
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	//
	// 一番可能性の高いブラシを選ぶ
	//
	public class BrushChoicer extends EventDispatcher
	{
		// event: change
		
		private var _currentBrush:String;
		private var brushPoints:Object;
		
		public function BrushChoicer(julian:JulianSocket)
		{
			this.reset();
			julian.addEventListener(JulianSocketEvent.WORD, onWord);
		}
		
		private function onWord(event:JulianSocketEvent):void {
			dispatchEvent(new Event("word"));
			var word:String = event.word;
			//trace(word);
			
			// brushポイントを加算
			if (!brushPoints[word]) {
				brushPoints[word] = 1;
			} else {
				brushPoints[word] += 1;
			}
			
			// ポイントの高いブラシを選ぶ
			// 2番目との差があまりなければ普通の線に戻す
			if (!_currentBrush || _currentBrush == "") {
				// first time
				//if (brushPoints[word] > 1) {
					changeBrushTo(word);
				//}
			} else if (word != _currentBrush
					   && brushPoints[word] > brushPoints[_currentBrush]) {
				changeBrushTo(word);
			}
		}
		
		private function changeBrushTo(newBrush:String):void {
			_currentBrush = newBrush;
			trace("change to "+_currentBrush);
			dispatchEvent(new Event("change"));
		}
		
		public function get currentBrush():String {
			return this._currentBrush || "";
		}

		public function reset():void {
			// 初期化
			this.brushPoints = {};
			this._currentBrush = "";
			dispatchEvent(new Event("restart"));
		}
	}
}