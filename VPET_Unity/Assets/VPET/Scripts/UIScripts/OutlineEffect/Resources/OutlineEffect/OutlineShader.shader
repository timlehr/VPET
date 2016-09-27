﻿/*
-----------------------------------------------------------------------------
This source file is part of VPET - Virtual Production Editing Tool
http://vpet.research.animationsinstitut.de/
http://github.com/FilmakademieRnd/v-p-e-t

Copyright (c) 2016 Filmakademie Baden-Wuerttemberg, Institute of Animation

This project has been realized in the scope of the EU funded project Dreamspace
under grant agreement no 610005.
http://dreamspaceproject.eu/

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free Software
Foundation; version 2.1 of the License.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place - Suite 330, Boston, MA 02111-1307, USA, or go to
http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
-----------------------------------------------------------------------------
*/

Shader "Hidden/OutlineEffect" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_LineColor ("Line Color", Color) = (1,1,1,.5)
		
	}
	SubShader 
	{
		Pass
		{
			Tags { "RenderType"="Opaque" }
			LOD 200
			ZTest Always
			ZWrite Off
			Cull Off
			
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			sampler2D _OutlineSource;

			struct v2f {
			   float4 position : SV_POSITION;
			   float2 uv : TEXCOORD0;
			};
			
			v2f vert(appdata_img v)
			{
			   	v2f o;
				o.position = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.texcoord;
				
			   	return o;
			}

			float _LineThicknessX;
			float _LineThicknessY;
			float _LineIntensity;
			half4 _LineColor1;
			int _FlipY;
			int _Dark;
			uniform float4 _MainTex_TexelSize;

			half4 frag (v2f input) : COLOR
			{	
				float2 uv = input.uv;
				if (_FlipY == 1)
					uv.y = 1 - uv.y;

				half4 originalPixel = tex2D(_MainTex,input.uv);
				half4 outlineSource = tex2D(_OutlineSource, uv);
								
				float h = .95f;
				half4 outline = 0;
				bool hasOutline = false;

				half4 sample1 = tex2D(_OutlineSource, uv + float2(_LineThicknessX,0.0) * _MainTex_TexelSize.x * 1000.0f);
				half4 sample2 = tex2D(_OutlineSource, uv + float2(-_LineThicknessX,0.0) * _MainTex_TexelSize.x * 1000.0f);
				half4 sample3 = tex2D(_OutlineSource, uv + float2(.0,_LineThicknessY) * _MainTex_TexelSize.y * 1000.0f);
				half4 sample4 = tex2D(_OutlineSource, uv + float2(.0,-_LineThicknessY) * _MainTex_TexelSize.y * 1000.0f);
				
				if(outlineSource.a < h)
				{
					if (sample1.r > h || sample2.r > h || sample3.r > h || sample4.r > h)
					{
						outline = _LineColor1 * _LineIntensity;
						hasOutline = true;
					}
				}					
					
				//return outlineSource;		
				if (_Dark)
				{
					if (hasOutline)
						return originalPixel * (1 - _LineColor1.a) + outline;
					else
						return originalPixel;
				}
				else
					return originalPixel + outline;
			}
			
			ENDCG
		}
	} 
	FallBack "Diffuse"
}