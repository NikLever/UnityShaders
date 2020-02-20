Shader "NiksShaders/Shader37Unlit"
{
    Properties
    {
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
            #include "noiseSimplex.cginc"

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 position: TEXCOORD1;
            };
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.position = v.vertex;
                return o;
            }

            float4 frag (v2f i) : COLOR
            {
                float2 p = i.position.xy * 2.0;
                float scale = 800.0;
                fixed3 color;
                bool marble = true;
                float noise;

                p *= scale;

                if (marble){
                    float d = perlin(p.x, p.y) * scale; 
                    float u = p.x + d;
                    float v = p.y + d;
                    d = perlin(u, v) * scale;
                    noise = perlin(p.x + d, p.y + d);
                    color = fixed3(0.6 * (fixed3(2,2,2) * noise - fixed3(noise * 0.1, noise * 0.2 - sin(u / 30.0) * 0.1, noise * 0.3 + sin(v / 40.0) * 0.2)));
                }else{
                    noise = perlin(p.x, p.y);
                    color = fixed3(1,1,1) * noise;
                }

                return fixed4( color, 1.0 );
            }
            ENDCG
        }
    }
}

