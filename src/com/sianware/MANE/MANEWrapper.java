package com.sianware.MANE;

import android.content.res.AssetManager;

public class MANEWrapper 
{
	@SuppressWarnings("unused")
	protected long enginePointer;
	
	public AssetManager assetManager;
	
	static {
		System.loadLibrary("lua5.2");
		System.loadLibrary("openal");
		System.loadLibrary("ogg");
		System.loadLibrary("vorbis");
		System.loadLibrary("mane");
	}
	
	public MANEWrapper(AssetManager manager)
	{
		assetManager = manager;
	}
	
	public native void DrawAndUpdate();
	
}
