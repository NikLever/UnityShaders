Shader "NiksShaders/Shader40Unlit"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _Duration("Duration", Float) = 6.0
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
                float2 uv: TEXCOORD0;
                float4 position: TEXCOORD1;
            };
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                o.position = v.vertex;
                return o;
            }

            sampler2D _MainTex;
            float _Duration;
            

            float4 frag (v2f i) : COLOR
            {
                float2 pos = i.position.xy * 2.0;
                float len = length(pos);
                float2 ripple = i.uv + pos/len*0.03*cos(len*12.0-_Time.y*4.0);
                float delta = (((sin(_Time.y)+1.0)/2.0)* _Duration)/_Duration;
                float2 uv = lerp(ripple, i.uv, 0);
                fixed3 color = tex2D(_MainTex, uv).rgb;

                return fixed4( color, 1.0 );
            }
            ENDCG
        }
    }
}

