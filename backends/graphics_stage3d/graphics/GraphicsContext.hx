/*
 * Created by IntelliJ IDEA.
 * User: epai
 * Date: 06/06/14
 * Time: 14:00
 */
package graphics;

import flash.display3D.textures.Texture;
import flash.display3D.Context3D;
import graphics.GraphicsTypes;
import haxe.ds.GenericStack;
import graphics.RenderTarget;

import haxe.ds.GenericStack;

class GraphicsContext {
    public var alpha:Bool;
    public var antialias:Bool;
    public var depth:Bool;
    public var premultipliedAlpha:Bool;
    public var preserveDrawingBuffer:Bool;
    public var stencil:Bool;

    public var currentBlendFactorSrc : BlendFactor;
    public var currentBlendFactorDest : BlendFactor;


    public var defaultRenderTarget : RenderTarget;
    public var currentActiveTextures = new Array<Texture>();
    public var currentActiveTexture : Int;

    public var currentRenderTargetStack:GenericStack<RenderTarget>;

    public var context3D(get_context3D, set_context3D):Context3D;
    private var _context3D:Context3D;

    public function get_context3D():Context3D {
        return _context3D;
    }

    public function set_context3D(value:Context3D):Context3D {
        this._context3D = value;
        return this._context3D;
    }

    public function new():Void {
        currentRenderTargetStack = new GenericStack<RenderTarget>();
        defaultRenderTarget = new RenderTarget();
        currentRenderTargetStack.add(defaultRenderTarget);
    }
}