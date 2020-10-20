Shader "NiksShaders/Shader16Unlit"
{
    Properties
    {
        _Color("Color", Color) = (1.0,1.0,1.0,1.0)
        _LineWidth("Line Width", Float) = 10.0
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
                float4 screenPos: TEXCOORD1;
            };
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.screenPos = ComputeScreenPos(o.vertex);
                return o;
            }
           
            fixed4 _Color;
            float _LineWidth;
            
            float onLine(float x, float y, float line_width, float edge_width){
            	float half_width = line_width * 0.5;
                return smoothstep(x-half_width-edge_width, x-half_width, y) - smoothstep(x+half_width, x+half_width+edge_width, y);
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.screenPos.xy / i.screenPos.w;
                fixed3 color = lerp(fixed3(0,0,0), _Color.rgb, onLine(uv.x, uv.y, _LineWidth, _LineWidth*0.1)); 
                
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
