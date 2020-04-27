Shader "NiksShaders/Shader67Unlit"
{
    Properties
    {
        _Radius("Radius", Float) = 0.4
        _Center("Center", Vector) = (0,0,0,0)
        _SphereColor("Color", Color) = (0,0,1,1)
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

            #define STEPS 100
            #define STEP_SIZE 0.0175

            float _Radius;
            float3 _Center;
            fixed4 _SphereColor;

            struct v2f {
                float4 position : SV_POSITION; // Clip space
                float3 worldPos : TEXCOORD1; // World position
            };
 
            // Vertex function
            v2f vert (appdata_base v)
            {
                 v2f o;
                 o.position = UnityObjectToClipPos(v.vertex);
                 o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz; 
                 return o;
            }

            // Fragment function
            fixed4 frag (v2f i) : SV_Target
            {
                 fixed4 col = 1;
                 return col;
            }
            ENDCG
        }
    }
    FallBack off
}
