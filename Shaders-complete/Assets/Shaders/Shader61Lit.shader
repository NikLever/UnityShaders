Shader "NiksShaders/Shader61Lit"
{
    Properties
    {
        [NoScaleOffset] _MainTex ("Texture", 2D) = "white" {}
        _Radius("Radius", Range(0, 3)) = 1
        _Position("Position", Vector) = (0,0,0,0)
        _CircleColor("Circle Color", Color) = ( 1,0,0,1 )
    }
    SubShader
    {
        Pass
        {
            Tags {"LightMode"="ForwardBase"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            // compile shader into multiple variants, with and without shadows
            // (we don't care about any lightmaps yet, so skip these variants)
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
            // shadow helper functions and macros
            #include "AutoLight.cginc"

            struct v2f
            {
                float2 uv : TEXCOORD0;
                SHADOW_COORDS(1) // put shadows data into TEXCOORD1
                fixed3 diff : COLOR0;
                fixed3 ambient : COLOR1;
                float4 pos : SV_POSITION;
                float3 worldPos: TEXCOORD2;
            };

            v2f vert (appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                o.diff = nl * _LightColor0.rgb;
                o.ambient = ShadeSH9(half4(worldNormal,1));
                o.worldPos = mul (unity_ObjectToWorld, v.vertex);
                // compute shadows data
                TRANSFER_SHADOW(o)
                return o;
            }

            sampler2D _MainTex;
            float4 _Position;
            fixed4 _CircleColor;
            float _Radius;

            float circle(float2 pt, float2 center, float radius, float line_width, float edge_thickness){
                float2 p = pt - center;
                float len = length(p);
                float half_line_width = line_width/2.0;
                float result = smoothstep(radius-half_line_width-edge_thickness, radius-half_line_width, len) - smoothstep(radius + half_line_width, radius + half_line_width + edge_thickness, len);

                return result;
            }

			float cross(float2 pt, float2 center, float radius, float line_width, float edge_thickness){
				float2 p = pt - center;
				float len = length(p);
				float half_line_width = line_width/2.0;
				float result = 0;
				if (len<radius){
					float horz = smoothstep(-half_line_width-edge_thickness, -half_line_width, p.y) - smoothstep( half_line_width, half_line_width + edge_thickness, p.y);
					float vert = smoothstep(-half_line_width-edge_thickness, -half_line_width, p.x) - smoothstep( half_line_width, half_line_width + edge_thickness, p.x);
					result = saturate(horz + vert);
				}
				return result;
			}
			
            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 col = tex2D(_MainTex, i.uv).rgb;
                // compute shadow attenuation (1.0 = fully lit, 0.0 = fully shadowed)
                fixed shadow = SHADOW_ATTENUATION(i);
                // darken light's illumination with shadow, keep ambient intact
                fixed3 lighting = i.diff * shadow + i.ambient;
                col *= lighting;

                float inCircle = cross(i.worldPos.xz, _Position.xz, _Radius, _Radius*0.1, _Radius*0.01);

                fixed3 finalColor = lerp(col, _CircleColor, inCircle);

                return fixed4(finalColor, 1);
            }
            ENDCG
        }

        // shadow casting support
        UsePass "Legacy Shaders/VertexLit/SHADOWCASTER"
    }
}
