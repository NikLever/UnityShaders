Shader "NiksShaders/Shader68Unlit"
{
    Properties
    {
        _Radius("Radius", Float) = 0.4
        _Center("Center", Vector) = (0,0,0,0)
        _Tex("Tex", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 100

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            float _Radius;
            float3 _Center;
			sampler2D _Tex;
			
            struct v2f {
                float4 position : SV_POSITION; // Clip space
                float3 worldPos : TEXCOORD1; // World position
            };
 
            // Vertex function
            v2f vert (appdata_full v)
            {
                 v2f o;
                 o.position = UnityObjectToClipPos(v.vertex);
                 o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz; 
                 return o;
            }
            
            float raymarch (float3 position, float3 direction)
            {
                float alpha = 0;
                int steps = 144;
                float step_size = 1.0 / steps;
                
                for (int i=0; i<steps; i++)
				{
					int index = floor((position.z - _Center.z + 0.5) * steps);
					float2 uv = saturate(position.xy - _Center.xy + 0.5) / 12.0;
					float2 offset = float2(fmod(index, 12), floor(float(index)/12.0))/12.0;
					float texel = tex2D( _Tex, uv + offset ).r;
					alpha += texel * step_size;
					position += direction * step_size;
				}
				
				return alpha;
            }
            
            // Fragment function
            fixed4 frag (v2f i) : SV_Target
            {
                 float3 viewDirection = normalize(i.worldPos - _WorldSpaceCameraPos);
                 float alpha = raymarch (i.worldPos, viewDirection);
                 return fixed4(1,1,1,alpha);
            }
            ENDCG
        }
    }
    FallBack off
}
