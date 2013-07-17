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
		GLES20.glViewport(0, 0, width, height);
	}

	@Override
	
	public void onDrawFrame(GL10 gl) 
	{
		nativeGame.DrawAndUpdate();
		//GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);
	}

}
