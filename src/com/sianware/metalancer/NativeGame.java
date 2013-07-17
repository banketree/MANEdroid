package com.sianware.metalancer;

import android.content.res.AssetManager;

import com.sianware.MANE.MANEWrapper;

public class NativeGame extends MANEWrapper
{
	static {
		System.loadLibrary("lua5.2");
		System.loadLibrary("openal");
		System.loadLibrary("ogg");
		System.loadLibrary("vorbis");
		System.loadLibrary("mane");
		System.loadLibrary("metalancer"); 
	}
	
	public NativeGame(AssetManager assets) 
	{
		super(assets);
	}
	
	public native void Start(String workingDir);
	public native void End();

}
