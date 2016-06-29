/*
 * Copyright (c) 2003-2016, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package graphics;

import types.Color4F;
import msignal.Signal.Signal2;
import msignal.Signal.Signal0;
import graphics.Graphics;
import graphics.GraphicsContext;
import graphics.GraphicsTypes;
import graphics.MeshData;
import graphics.Shader;
import graphics.TextureData;

import types.DataType;
import types.Data;


extern class Graphics
{
    public var onRender(default, null) : Signal0;
    public var onMainContextSizeChanged : Signal0;

    // Context was lost, so you need to recreate all you graphic objects and invalidate all state caches
    public var onMainContextRecreated : Signal0;
    public var mainContextWidth(default, null) : Int;
    public var mainContextHeight(default, null) : Int;

	private function new() : Void;

    public function setDefaultGraphicsState() : Void;
    public function rebindDefaultBackbuffer() : Void; // Just needed when the context was lost and is recreated;

	public static function instance() : Graphics;
	public static function initialize(onInitializd:Void->Void) : Void;

    ///######## STATE HANDLING ########
    public function enableGraphicsAPI(enable: Bool): Void;
    public function invalidateCaches(): Void;

    ///######## CONTEXT ########
    public function getMainContext() : GraphicsContext;

    public function loadFilledContext(context : GraphicsContext) : Void;
    public function isLoadedContext(context : GraphicsContext) : Bool;
    public function unloadFilledContext(context : GraphicsContext) : Void;

    public function getCurrentContext() : Null<GraphicsContext>;
    public function pushContext(context : GraphicsContext) : Void;
    public function popContext() : Null<GraphicsContext>;

    ///######## LOAD ########
	public function loadFilledMeshData(meshData : MeshData) : Void;
    public function loadFilledVertexBuffer(meshData : MeshData) : Void;///called by loadFilledMeshData
    public function loadFilledIndexBuffer(meshData : MeshData) : Void;///called by loadFilledMeshData
	public function loadFilledShader(shader : Shader) : Void;
	public function loadFilledTextureData(textureData : TextureData) : Void;
    public function loadFilledRenderTargetData(renderTarget : RenderTargetData) : Void;

    public function isLoadedMeshData(meshData : MeshData) : Bool;
    public function isLoadedMeshDataBuffer(meshDataBuffer : MeshDataBuffer) : Bool; ///called by isLoadedMeshData
    public function isLoadedShader(shader : Shader) : Bool;
    public function isLoadedTextureData(textureData : TextureData) : Bool;
    public function isLoadedRenderTargetData(renderTarget : RenderTargetData) : Bool;

    public function unloadMeshData(meshData : MeshData) : Void;
    public function unloadShader(shader : Shader) : Void;
    public function unloadTextureData(textureData : TextureData) : Void;
    public function unloadRenderTargetData(renderTarget : RenderTargetData) : Void;

    ///######## UPDATE ########
    public function updateFilledTextureData(textureData : TextureData, offsetX: Int, offsetY: Int) : Void;

    ///######## BLENDING ########
    public function setBlendFunc(sourceFactor : BlendFactor, destinationFactor : BlendFactor) : Void;

    ///######## DEPTH TESTING ########
    public function enableDepthWrite(enabled : Bool) : Void;
    public function isDepthWriting() : Null<Bool>;
    public function setDepthFunc(depthFunc : DepthFunc) : Void;
    public function getDepthFunc() : Null<DepthFunc>;

    ///######## FACE CULLING ########
    public function setFaceCullingMode(cullingMode : FaceCullingMode) : Void;
    public function getFaceCullingMode() : Null<FaceCullingMode>;

    ///######## COLOR MASK ########
    public function setColorMask(writeRed : Bool, writeGreen : Bool, writeBlue : Bool, writeAlpha : Bool) : Void;

    ///######## RENDER TARGET ########
    public function pushRenderTargetData(renderTarget : RenderTargetData): Void;
    public function popRenderTargetData(): Null<RenderTargetData>;
    public function discardRenderTargetData(renderTarget : RenderTargetData): Void; // Does nothing, if not supported
    public function getDefaultRenderTargetData(): Null<RenderTargetData>;

    ///######## ENABLE SCISSOR TESTING ########
    public function enableScissorTesting(enabled : Bool) : Void;
    public function setScissorTestRect(x : Int, y : Int, width : Int, height : Int) : Void;

    ///######## RENDER ########
	public function bindShader(shader : Shader) : Void;
	public function bindMeshData(meshData : MeshData, bakedFrame : Int) : Void;
    public function unbindMeshData(meshData : MeshData) : Void;
	public function bindTextureData(texture : TextureData, position : Int) : Void;
	public function render(meshData : MeshData, bakedFrame : Int) : Void;
    public function present() : Void;

    ///######## RENDER TARGET ########
    public function setClearColor(color: Color4F): Void;
	public function clearColorBuffer() : Void;
    public function clearDepthBuffer() : Void;
    public function clearStencilBuffer() : Void;
    public function clearAllBuffers() : Void;
    public function clearColorStencilBuffer(): Void;
    public function clearStencilDepthBuffer(): Void;

    ///######## GRAPHICS STATE ########
    public function finishCommandPipeline() : Void;
    public function flushCommandPipeline() : Void;

    ///######## STENCIL ########
    public function enableStencilTest(enabled : Bool) : Void;
    public function isStencilTestEnabled() : Null<Bool>;

    public function setStencilFunc(stencilFunc : StencilFunc, referenceValue : Int, readMask : Int) : Void;
    public function setStencilOp(stencilFail : StencilOp, depthFail : StencilOp, stencilAndDepthPass : StencilOp) : Void;
    public function setStencilMask(writeMask : Int) : Void;

    ///######## VIEWPORT ########
    public function setViewPort(x: Int, y: Int, width: Int, height: Int): Void;

	///######## STATS ########
	public function getMeshMemoryUsage(): Int;	// MB
	public function getTextureMemoryUsage(): Int;	// MB
	public function getRenderTargetMemoryUsage(): Int;	// MB

    ///######## LIMITS ########
    public function getMaxTextureSize(): Null<Int>;
    public function getMaxRenderbufferSize(): Null<Int>;
    public function getMaxCubeTextureSize(): Null<Int>;

    ///######## ??? ########
    public function readTextureData(textureData: TextureData, x: UInt, y: UInt, width: UInt, height: UInt): BitmapData;

	public static var maxActiveTextures : Int;
}
