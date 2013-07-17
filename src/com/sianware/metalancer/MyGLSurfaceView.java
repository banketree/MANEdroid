package com.sianware.metalancer;

import com.sianware.MANE.MANEWrapper;

import android.content.Context;
import android.opengl.GLSurfaceView;

public class MyGLSurfaceView extends GLSurfaceView 
{

	public MyGLSurfaceView(Context context, NativeGame maneWrapper) 
	{
		super(context);
		setEGLContextClientVersion(2);
		setRenderer(new MyRenderer(maneWrapper));
	}

}
