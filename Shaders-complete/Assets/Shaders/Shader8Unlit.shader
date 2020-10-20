Shader "NiksShaders/Shader8Unlit"
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

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 position: TEXCOORD1;
                float2 uv : TEXCOORD0;
            };
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.position = v.vertex;
                o.uv = v.texcoord;
                return o;
            }

            float rect(float2 pt, float2 size, float2 center){
                float2 p = pt - center;
                float2 halfsize = size * 0.5;

                float horz = step(-halfsize.x, p.x) - step(halfsize.x, p.x);
                float vert = step(-halfsize.y, p.y) - step(halfsize.y, p.y);

                return horz * vert;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 pos = i.position.xy * 2.0;
                float square1 = rect(pos, float2(0.3, 0.3), float2(-0.5, 0.0));
                float square2 = rect(pos, float2(0.4, 0.4), float2( 0.5, 0.0));
                fixed3 color = fixed3(1.0,1.0,0.0) * square1 + fixed3(0.0, 1.0, 0.0) * square2;
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
