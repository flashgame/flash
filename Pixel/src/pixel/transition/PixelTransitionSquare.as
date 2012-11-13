package pixel.transition
{
	import flash.events.EventDispatcher;
	
	import pixel.transition.event.PixelTransitionEvent;

	/**
	 * 
	 * 批量过渡
	 * 
	 **/
	public class PixelTransitionSquare extends EventDispatcher
	{
		private var _beginQueue:Vector.<IPixelTransition> = null;
		private var _completeCount:int = 0;
		public function PixelTransitionSquare()
		{
			
		}
		
		/**
		 * 开始批处理
		 * 
		 * 
		 **/
		public function begin(queue:Array):void
		{
			_beginQueue = new Vector.<IPixelTransition>(queue);
			
			for each(var transition:IPixelTransition in _beginQueue)
			{
				transition.addEventListener(PixelTransitionEvent.TRANS_COMPLETE,onTransitionNodeComplete);
				transition.begin();
			}
		}
		
		/**
		 * 一个节点成功完成
		 * 
		 * 
		 **/
		protected function onTransitionNodeComplete(event:PixelTransitionEvent):void
		{
			_completeCount++;
			if(_completeCount == _beginQueue.length)
			{
				//全部节点完成过渡
				dispatchEvent(new PixelTransitionEvent(PixelTransitionEvent.TRANS_SQUARE_COMPLETE));
			}
		}
	}
}