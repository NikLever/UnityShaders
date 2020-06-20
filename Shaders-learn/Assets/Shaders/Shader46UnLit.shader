Shader "NiksShaders/Shader46Unlit"
{
    Properties
    {
        _Scale("Scale", Range(0.1, 3)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv: TEXCOORD0;
                float4 noise: TEXCOORD1;
            };

            float _Scale;
            
            v2f vert (appdata_base v)
            {
                v2f o;
                
                o.noise = 0;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed3 color = fixed3( i.uv * ( 1. - 2. * i.noise.x ), 0.0 );

                return fixed4( color, 1 );
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}

