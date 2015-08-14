/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 04/06/14
 * Time: 14:34
 */
package graphics;

import haxe.ds.Vector;
import graphics.GraphicsTypes;

extern class GraphicsContext
{
    public var depthWrite : Null<Bool> = null;
    public var depthFunc : DepthFunc;

	public var stencilingEnabled : Null<Bool> = null;

    public var antialias: Bool;
    public var premultipliedAlpha: Bool;
    public var preserveDrawingBuffer: Bool;

    public function invalidateCaches(): Void;
}    
