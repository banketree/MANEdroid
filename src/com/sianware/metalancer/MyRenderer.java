package com.sianware.metalancer;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import com.sianware.MANE.MANEWrapper;

import android.opengl.GLES20;
import android.opengl.GLSurfaceView;

public class MyRenderer implements GLSurfaceView.Renderer 
{ 
	private NativeGame nativeGame;
	
	public MyRenderer(NativeGame nativeGame)
	{
		this.nativeGame = nativeGame;
	}
	
	@Override
	public void onSurfaceCreated(GL10 gl, EGLConfig config)
	{
		nativeGame.Start("");
	}
	
	@Override
	public void onSurfaceChanged(GL10 gl, int width, int height)
	{
		nativeGame.LoadContext(width, height);
	}

	boolean frameRendered = false;
	
	@Override
	public void onDrawFrame(GL10 gl) 
	{
		nativeGame.DrawAndUpdate();
	}

}
