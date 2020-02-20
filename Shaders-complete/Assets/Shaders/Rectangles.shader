Shader "NiksShaders/Rectangles"
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

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            bool inRect( float2 pt, float4 rect){
                //Returns true if pos is in the rect
                return pt.x>rect.x && pt.x<(rect.x + rect.z) && pt.y>rect.y && pt.y<(rect.y + rect.w);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float square1 = (inRect( i.uv, float4(0.1, 0.1, 0.2, 0.2))) ? 1.0 : 0.0;
                float square2 = (inRect( i.uv, float4( 0.5, 0.5, 0.3, 0.3))) ? 1.0 : 0.0;
                return float4(float3(1.0,1.0,0.0) * square1 + float3(0.0, 1.0, 0.0) * square2, 1.0);
            }
            ENDCG
        }
    }
}
