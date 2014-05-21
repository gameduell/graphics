package renderer;

import renderer.RenderTypes;

import types.DataType;
import types.Data;

import lime.Lime;

import renderer.RendererImplementation;


extern class MeshDataBuffer 
{
	public var bufferMode : BufferMode;
	public var data : Data;

	public function new() : Void;
}

extern class MeshDataAttributeConfig
{
	public var attributeNumber : Int = 0;
	public var stride : Int = 0;
	public var vertexElementCount : Int = 0;
	public var vertexElementType : DataType;
	public var offsetInData : Int = 0;
	public var offsetPerBakedFrame : Array<Int>;
	public var vertexElementsNormalized : Bool = false;

	public function new() : Void;
}

extern class MeshData
{
	public var attributeBuffer : MeshDataBuffer;
	public var indexBuffer : MeshDataBuffer;
	public var attributeConfigs : Array<MeshDataAttributeConfig>;

	public var vertexCount : Int = 0;
	public var indexCount : Int = 0;
	public var bakedFrameCount : Int = 0;
	public var bakedFPS : Int = 0;

	public var primitiveType : PrimitiveType;
	public var indexDataType : DataType;
	public var indexCountPerBakedFrame : Array<Int>;
	public var indexOffsetPerBakedFrame : Array<Int>;

	public function new() : Void;
}

extern class ShaderUniformInterface
{
	public var dataCount : Int = 0;
	public var uniformType : UniformType;
	
	public var shaderVariableName : String;

	public var data : Data;
	public var dataActiveCount : Int = 0;

	public function new() : Void;

	/// helper function, creates the underlying data with the appropriate size
	public function setup(shaderVariableName : String, uniformType : UniformType, count : Int = 1);
}	

extern class Shader
{
	public var name : String;

	/// Since HXSL is unstable, we will ifdef the shader code on client side.
	public var vertexShaderCode : Dynamic;
	public var fragmentShaderCode : Dynamic;

	public var uniformInterfaces : Array<ShaderUniformInterface>;

	public var attributeNames : Array<String>;


	/// shader caching, the constructor will add the shader to the cache if a name is passed
	static public var shaderCache : Map<String, Shader>;
	static public function checkForCachedShader(name : String) : Shader;
	public function new(?name : String) : Void;
}

extern class TextureData
{
	public var pixelFormat : TextureFormat;
	public var textureType : TextureType;
	public var hasAlpha : Bool;
	public var hasPremultipliedAlpha : Bool;
	public var originalHeight : Int;
	public var originalWidth : Int;

	public var hasMipMaps : Bool;

	public var filteringMode : TextureFilteringMode;
	public var wrap : TextureWrap;

	public var data : Data;

    public var dataForCubeMapPositiveX : Data;
    public var dataForCubeMapNegativeX : Data;
    public var dataForCubeMapPositiveY : Data;
    public var dataForCubeMapNegativeY : Data;
    public var dataForCubeMapPositiveZ : Data;
    public var dataForCubeMapNegativeZ : Data;

    public function new() : Void;
}

extern class Renderer
{
	private function new() : Void;
	public static function instance() : Renderer : Void;

	public function loadFilledMeshData(meshData : MeshData) : Void;

	public function loadFilledShader(shader : Shader) : Void;

	public function loadFilledTextureData(textureData : TextureData) : Void;

	public function bindShader(shader : Shader) : Void;
	public function bindMeshData(meshData : MeshData, bakedFrame : Int) : Void;
	public function bindTextureData(texture : TextureData, position : Int) : Void;
	public function render(meshData : MeshData, bakedFrame : Int) : Void;

	/// pre render target methods
	public function setClearColor(r : Float, g : Float, b : Float, a : Float) : Void;
	public function clear() : Void;

	public static var maxActiveTextures : Int;
}


