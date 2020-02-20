Shader "NiksShaders/Shader27Unlit"
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

            #define PI 3.14159265359
            #define PI2 6.28318530718


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

            float random (float2 pt) {
                const float a = 12.9898;
                const float b = 78.233;
                const float c = 43758.543123;
                return frac(sin(dot(pt, float2(a, b))) * c );
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 color = random(i.uv) * fixed3(1,1,1);
                
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
