package com.sianware.metalancer;

import com.sianware.MANE.MANEWrapper;

import android.app.Activity;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.view.Menu;

public class MainActivity extends Activity 
{
	private GLSurfaceView glView;
	
	private NativeGame nativeGame;
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		
		nativeGame = new NativeGame(getAssets());
		
		glView = new MyGLSurfaceView(this,nativeGame);
		setContentView(glView);
		
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu)
	{
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}
