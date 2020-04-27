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
                float alpha = 1;
                return fixed4(1,1,1,alpha);
            }
            ENDCG
        }
    }
    FallBack off
}
