package shaders;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxShader;
import flixel.system.FlxGraphicAsset;

/**
 * ...
 * @author isaac
 */
class BasicMaskShader extends FlxShader
{
	@:glFragmentSource('
	#pragma header
	uniform sampler2D mainPalette;
	
	uniform float relativePosX;
	uniform float relativePosY;
	
	uniform float sizeX;
	uniform float sizeY;
	
	void main()
	{
		
		if (texture2D(mainPalette, vec2(openfl_TextureCoordv.x * sizeX - relativePosX, openfl_TextureCoordv.y * sizeY - relativePosY)).a > 0.1)
		{
			gl_FragColor = texture2D(bitmap, openfl_TextureCoordv);
		}
		else gl_FragColor = vec4(0.0);
		
		
		//if you want a reverse mask (i.e, a porthole-style mask or something), youd smiply switch it to this:
		
		/*
		 * if (texture2D(mainPalette, vec2(openfl_TextureCoordv.x * sizeX + relativePosX, openfl_TextureCoordv.y * sizeY + relativePosY)).a > 0.1)
		{
			gl_FragColor = gl_FragColor = vec4(0.0);
		}
		else  texture2D(bitmap, openfl_TextureCoordv);
		 * 
		 * 
		 * */
	}
	')
	public function new(maskSprite:FlxGraphicAsset) 
	{
		super();
		setData(maskSprite);
	}
	
	public function setData(maskSprite:FlxGraphicAsset, tsizeX:Float = 1, tsizeY:Float = 1, trelativePosX:Float = 0, trelativePosY:Float = 0)
	{
		var mp:FlxSprite = new FlxSprite(0, 0);
		
		//for some reason I couldn't get BitmapData.loadFile() to work
		mp.loadGraphic(maskSprite);
		data.mainPalette.input = mp.graphic.bitmap;
		
		mp.destroy();
		setPosAndSize(tsizeX, tsizeY, trelativePosX, trelativePosY);
	}
	
	public function setPosAndSize(tsizeX:Float = 1, tsizeY:Float = 1, trelativePosX:Float = 0, trelativePosY:Float = 0)
	{
		data.relativePosX.value = [trelativePosX];
		data.relativePosY.value = [trelativePosY];
		
		data.sizeX.value = [1/tsizeX];
		data.sizeY.value = [1/tsizeY];
	}

	

	
}
