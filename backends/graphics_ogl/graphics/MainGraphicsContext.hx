/*
 * Created by IntelliJ IDEA.
 * User: rcam
 * Date: 04/06/14
 * Time: 14:45
 */
package graphics;

import gl.GLExtDefines;
import gl.GLExt;
import haxe.ds.Vector;
import graphics.GraphicsContext;
import gl.GL;
import gl.GLDefines;
import gl.GLContext;
import graphics.GraphicsTypes;
import haxe.ds.GenericStack;
import graphics.RenderTargetData;

import haxe.ds.GenericStack;

class MainGraphicsContext extends GraphicsContext
{
    public function new() : Void
    {
        super();
    }

    public function initialize(finishedCallback : Void->Void)
    {
        currentShader = GL.nullProgram;
        var maxActiveTextures = GraphicsContext.maxActiveTextures;
        currentActiveTexture = maxActiveTextures + 1;

        for(val in 0...maxActiveTextures)
        {
            currentActiveTextures.push(GL.nullTexture);
        }

        currentRenderTargetDataStack = new GenericStack<RenderTargetData>();
        currentLineWidth = 1;
        currentDepthTesting = false;

        GLContext.setupMainContext(function ()
        {
            glContext = GLContext.getMainContext();
            defaultRenderTargetData = new RenderTargetData();
            defaultRenderTargetData.framebufferID = GL.getParameter(GLDefines.FRAMEBUFFER_BINDING);
            defaultRenderTargetData.discardColor = true;
            defaultRenderTargetData.discardDepth = true;
            defaultRenderTargetData.discardStencil = true;
            currentRenderTargetDataStack.add(defaultRenderTargetData);

            determinePlatformGraphicsCapabilities();

            finishedCallback();
        });
    }

    private function determinePlatformGraphicsCapabilities(): Void
    {
        GraphicsContext.vendor = GL.getParameter(GLDefines.VENDOR);
        GraphicsContext.version = GL.getParameter(GLDefines.VERSION);
        GraphicsContext.renderer = GL.getParameter(GLDefines.RENDERER);

#if html5
        GraphicsContext.extensions = Std.string(GL.getSupportedExtensions());
#else
        var extensionsString: String = GL.getParameter(GLDefines.EXTENSIONS);

        if (extensionsString == null)
        {
            extensionsString = "GL_INVALID_ENUM";
        }

        GraphicsContext.extensions = extensionsString;
#end

        trace("##### Graphic Hardware Description #####");
        GraphicsContext.vendor != null ? trace("Vendor: ", GraphicsContext.vendor) : trace("Vendor: null");
        GraphicsContext.version != null ? trace("Version: ", GraphicsContext.version) : trace("Version: null");
        GraphicsContext.renderer != null ? trace("Renderer: ", GraphicsContext.renderer) : trace("Renderer: null");
        GraphicsContext.extensions != null ? trace("Extensions: ", GraphicsContext.extensions) : trace("Extensions: null");
        trace("##### Enabled Extensions #####");

        if (GraphicsContext.extensions.indexOf(GLExtDefines.EXT_discard_framebuffer) != -1)
        {
            this.supportsDiscardFramebuffer = true;
            trace(GLExtDefines.EXT_discard_framebuffer);
        }

        if (GraphicsContext.extensions.indexOf(GLExtDefines.OES_vertex_array_object) != -1)
        {
            this.supportsVertexArrayObjects = true;
            trace(GLExtDefines.OES_vertex_array_object);
        }

        trace("########################################");
    }
}