Shader "NiksShaders/Shader39Unlit"
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

            float2 rotate(float2 pt, float aspect, float theta){
                float c = cos(theta);
                float s = sin(theta);
                float2x2 mat = float2x2(c,s,-s,c);
                pt.y /= aspect;
                pt = mul(pt, mat);
                pt.y *= aspect;
                return pt;
            }

            float4 frag (v2f i) : COLOR
            {
                float2 uv = i.uv;
                float2 center = float2(0.5, 0.5);
                float aspect = 2.0/1.5;
                uv -= center;
                uv = rotate(uv, aspect, _Time.y);
                uv += center;
                fixed3 color;
                if (uv.x<0.0||uv.x>1.0||uv.y<0.0||uv.y>1.0){
                    color = fixed3(0,0,0);
                }else{
                    color = tex2D(_MainTex, uv).rgb;
                }

                return fixed4( color, 1.0 );
            }
            ENDCG
        }
    }
}

