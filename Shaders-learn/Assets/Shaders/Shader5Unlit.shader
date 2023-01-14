Shader "NiksShaders/Shader5Unlit"
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

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            fixed4 frag (v2f_img i) : SV_Target
            {
                fixed3 color = 1;
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
