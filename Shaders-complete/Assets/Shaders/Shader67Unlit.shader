Shader "NiksShaders/Shader67Unlit"
{
    Properties
    {
        _Radius("Radius", Float) = 0.4
        _Center("Center", Vector) = (0,0,0,0)
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

            #define STEPS 100
            #define STEP_SIZE 0.0175

            float _Radius;
            float3 _Center;

            struct v2f {
                float4 pos : SV_POSITION; // Clip space
                float3 wPos : TEXCOORD1; // World position
            };
 
            // Vertex function
            v2f vert (appdata_full v)
            {
                 v2f o;
                 o.pos = UnityObjectToClipPos(v.vertex);
                 o.wPos = mul(unity_ObjectToWorld, v.vertex).xyz; 
                 return o;
            }

            fixed4 raymarch (float3 position, float3 direction)
            {
                 for (int i = 0; i < STEPS; i++)
                 {
                     if ( length(position - _Center.xyz) < _Radius )
                        return fixed4(1,0,0,1); // Red
 
                     position += direction * STEP_SIZE;
                 }
 
                 return fixed4(1,1,1,-1); // White
            }

            // Fragment function
            fixed4 frag (v2f i) : SV_Target
            {
                 float3 viewDirection = normalize(i.wPos - _WorldSpaceCameraPos);
                 fixed4 col = raymarch (i.wPos, viewDirection);
                 clip(col);
                 return col;
            }
            ENDCG
        }
    }
    FallBack off
}
