package pixel.worker.core
{
	/**
	 * 线程基类接口
	 * 
	 * 
	 */
	public interface IPixelWorker
	{
		function start():void;
		function terminal():void;
	}
}