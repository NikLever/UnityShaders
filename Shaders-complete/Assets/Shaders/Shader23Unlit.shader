Shader "NiksShaders/Shader23Unlit"
{
    Properties
    {
        _Sides("Sides", Int) = 3
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
            
            int _Sides;

            float getDelta(float x){
                return (sin(x)+1.0)/2.0;
            }

            float circle(float2 pt, float2 center, float radius, float line_width, float edge_thickness){
                pt -= center;
                float len = length(pt);
                //Change true to false to soften the edge
                float result = smoothstep(radius-line_width/2.0-edge_thickness, radius-line_width/2.0, len) - smoothstep(radius + line_width/2.0, radius + line_width/2.0 + edge_thickness, len);

                return result;
            }

            float onLine(float x, float y, float line_width, float edge_width){
                return smoothstep(x-line_width/2.0-edge_width, x-line_width/2.0, y) - smoothstep(x+line_width/2.0, x+line_width/2.0+edge_width, y);
            }

            float polygon(float2 pt, float2 center, float radius, int sides, float rotate, float edge_thickness){
                pt -= center;

                // Angle and radius from the current pixel
                float theta = atan2(pt.y, pt.x) + rotate;
                float rad = PI2/float(sides);

                // Shaping function that modulate the distance
                float d = cos(floor(0.5 + theta/rad)*rad-theta)*length(pt);

                return 1.0 - smoothstep(radius, radius + edge_thickness, d);
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float2 pt = i.screenPos.xy * _ScreenParams.xy;
                float2 center = _ScreenParams.xy * 0.5;
                float radius = 80.0;
                fixed3 color = polygon(pt, center, radius, _Sides, 0.0, 1.0) * fixed3(1.0, 1.0, 0.0);
                color += circle(pt, center, radius, 1.0, 1.0) * fixed3(1.0, 1.0, 1.0); 
                
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
