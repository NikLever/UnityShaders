Shader "NiksShaders/Shader59Unlit"
{
    Properties
    {
        _MainTex("Base (RGB)", 2D) = "white" {}
        _Luminosity("Luminosity", Range(0, 1)) = 1.0
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
            #pragma fragmentoption ARB_precision_hint_fastest

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            fixed _Luminosity;

            fixed4 frag (v2f_img i) : SV_Target
            {
                fixed4 renderTex = tex2D(_MainTex, i.uv);
                float luminosity = 0.299 * renderTex.r + 0.587 * renderTex.g + 0.114 * renderTex.b;
                fixed finalColor = lerp(renderTex, luminosity, _Luminosity);
                renderTex.rgb = finalColor;

                return renderTex;

            }
            ENDCG
        }
    }
    FallBack off
}
