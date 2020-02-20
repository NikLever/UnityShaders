﻿Shader "NiksShaders/Shader32Unlit"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members position)
#pragma exclude_renderers d3d11
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 screenPos: TEXCOORD2;
                float4 position: TEXCOORD1;
                float2 uv: TEXCOORD0;
            };
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.screenPos = ComputeScreenPos(o.vertex);
                o.position = v.vertex;
                o.uv = v.texcoord;
                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col;
                fixed3 color;
                float2 uv = i.uv * 2.0;
                if (i.uv.x<0.5){
                    if (i.uv.y<0.5){
                        col = tex2D(_MainTex, uv);
                        color = fixed3(col.b, col.b, col.b);
                    }else{
                        col = tex2D(_MainTex, uv-float2(0.0, 1.0));
                        color = fixed3(col.r, col.r, col.r);
                    }
                }else{
                    if (i.uv.y<0.5){
                        col = tex2D(_MainTex, uv-float2(1.0, 0.0));
                        color = fixed3(col.a, col.a, col.a);
                    }else{
                        col = tex2D(_MainTex, uv-float2(1.0, 1.0));
                        color = fixed3(col.g, col.g, col.g);
                    }
                }
                
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
