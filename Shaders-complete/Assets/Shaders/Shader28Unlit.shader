Shader "NiksShaders/Shader28Unlit"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag

            #include "UnityCG.cginc"

            float random (float2 pt, float seed) {
                const float a = 12.9898;
                const float b = 78.233;
                const float c = 43758.543123;
                return frac(sin(dot(pt, float2(a, b)) + seed) * c );
            }

            fixed4 frag (v2f_img i) : SV_Target
            {
                fixed3 color = random(i.uv, _Time.y) * fixed3(1,1,1);
                
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
