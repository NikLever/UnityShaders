Shader "NiksShaders/Shader41Unlit"
{
    Properties
    {
        _TextureA("Texture A", 2D) = "white" {}
        _TextureB("Texture B", 2D) = "white" {}
        _Duration("Duration", Float) = 6.0
        _StartTime("StartTime", Float) = 0
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

            sampler2D _TextureA;
            sampler2D _TextureB;
            float _Duration;
            float _StartTime;
             
            float4 frag (v2f i) : COLOR
            {
                float time = _Time.y - _StartTime;
                float2 p = -1.0 + 2.0 * i.uv;
                float len = length(p);
                float2 ripple = i.uv + (p/len)*cos(len*12.0-time*4.0)*0.03;
                float delta = saturate(time/_Duration);
                float2 uv = lerp(ripple, i.uv, delta);
                fixed3 col1 = tex2D(_TextureA, uv).rgb;
                fixed3 col2 = tex2D(_TextureB, uv).rgb;
                float fade = smoothstep(delta*1.4, delta*2.5, len);
                fixed3 color = lerp(col2, col1, fade);
                
                return fixed4( color, 1.0 );
            }
            ENDCG
        }
    }
}

