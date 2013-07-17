/*

caligari's scanlines

    Copyright (C) 2011 caligari

    This program is free software; you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the Free
    Software Foundation; either version 2 of the License, or (at your option)
    any later version.

    (caligari gave their consent to have this shader distributed under the GPL
    in this message:

        http://board.byuu.org/viewtopic.php?p=36219#p36219

        "As I said to Hyllian by PM, I'm fine with the GPL (not really a bi
        deal...)"
   )

*/

//modded by sfuller

#version 110

uniform sampler2D texture;
uniform vec2 tint;
varying vec2 vTextureSize;
varying vec2 vTexcoord;



// 0.5 = the spot stays inside the original pixel	
// 1.0 = the spot bleeds up to the center of next pixel	
#define SPOT_WIDTH  0.6

// Used to counteract the desaturation effect of weighting.
#define COLOR_BOOST 1.5

// for scanline effect, 0.5 to 0.7 in height	
#define SPOT_HEIGHT 0.5

// Uncomment this to have darker pixels producing smaller spots.
//#define SPOT_SIZE_IS_INFLUENCED_BY_LUMI

// Constants used with gamma correction.
#define InputGamma 2.4
#define OutputGamma 2.2
	
// Uncomment one of these to choose a gamma correction method.
// If none are uncommented, no gamma correction is done.
// #define REAL_GAMMA
#define FAKE_GAMMA
// #define FAKER_GAMMA

#ifdef REAL_GAMMA
#define GAMMA_IN(color)     pow(color, vec4(InputGamma))
#define GAMMA_OUT(color)    pow(color, vec4(1.0 / OutputGamma))
#elif defined FAKE_GAMMA
/*
 * Approximations:
 * for 1<g<2 : x^g ~ ax + bx^2
 *             where   a=6/(g+1)-2  and b=1-a
 * for 2<g<3 : x^g ~ ax^2 + bx^3
 *             where   a=12/(g+1)-3 and b=1-a	
 * for 1<g<2 : x^(1/g) ~ (sqrt(a^2+4bx)-a)
 *             where   a=6/(g+1)-2  and b=1-a
 * for 2<g<3 : Not computed yet, probably needs cube_root...
 *             so no better than using pow ?
 */

  
vec4 A_IN = vec4( 12.0/(InputGamma+1.0)-3.0 );
vec4 B_IN = vec4(1.0) - A_IN;
#define GAMMA_IN(color)     ( (A_IN + B_IN * color) * color * color )
#define GAMMA_OUT(color)    pow(color, vec4(1.0 / OutputGamma ))

#elif defined FAKER_GAMMA
vec4 A_IN = vec4( 6.0/( InputGamma/OutputGamma + 1.0 ) - 2.0 );
vec4 B_IN = vec4(1.0) - A_IN;
#define GAMMA_IN(color)     ( (A_IN + B_IN * color) * color )
#define GAMMA_OUT(color)    color

#else // No gamma correction
#define GAMMA_IN(color) color
#define GAMMA_OUT(color) color
#endif

#define TEX2D(coords)   GAMMA_IN( texture2D(texture, coords) )

#ifdef SPOT_SIZE_IS_INFLUENCED_BY_LUMI
float lumi;
float size;

vec4 lumW = vec4( 0.3, 0.6, 0.1, 0.0 );

// Define SIZE to decrease the spot-size for darker pixels.
// the last parenthesis needs work...

#define SIZE(col) \
	lumi = dot(col, lumW); \
        size = SPOT_WIDTH * ( 0.5 + 0.5 * lumi);

#else
float size = SPOT_WIDTH;
// in this case, the size is fixed => the macro does nothing
#define SIZE(col)
#endif // SPOT_SIZE_IS_INFLUENCED_BY_LUMI

vec2 onex = vec2( 2.0/vTextureSize.x, 0.0 );

void main()
{
	vec2 coords = ( vTexcoord.xy * vTextureSize );
	vec2 pixel_center = floor( coords ) + vec2(0.5);

        vec2 texture_coords = pixel_center / vTextureSize;

        vec4 color = TEX2D( texture_coords );

	float dx = coords.x - pixel_center.x;

	// macro to determinate spot size
        // can be fixed or influenced by the pixel luminosity	
        SIZE( color );
	float weight = dx / size;
	if (weight>1.0) weight = 1.0;
                weight = 1.0 - weight * weight;

        color *= vec4( weight * weight * COLOR_BOOST );

        // get closest neighbour to blend
        vec4 colorNB;
        if (dx>0.0) 
	{
        	colorNB = TEX2D( texture_coords + onex );
                dx = 1.0 - dx;
        }
	else 
	{
		colorNB = TEX2D( texture_coords - onex );
               	dx = 1.0 + dx;
        }
        
	// macro to determinate spot size
	// can be fixed or influenced by the pixel luminosity
	SIZE( colorNB );

	weight = dx / size;
        if (weight>1.0) weight = 1.0;
        	weight = 1.0 - weight * weight;

        color = color + colorNB * vec4(weight * weight  * COLOR_BOOST);

	// scanline
     	float dy = coords.y - pixel_center.y;	
        weight = ( dy / SPOT_HEIGHT ) * .5;
        weight = 1.0 - weight * weight;
        color *= vec4(weight * weight);

		
	gl_FragColor = clamp(GAMMA_OUT(color), 0.0, 1.0);
}



