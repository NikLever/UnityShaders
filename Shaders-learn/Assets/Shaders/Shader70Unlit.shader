Shader "NiksShaders/Shader70Unlit"
{
    Properties
    {
        _MainTex("Base (RGB)", 2D) = "white" {}
        _Tint("Tint", Range(0, 1)) = 1.0
        _ScanLines("Scanlines", Range(50, 150)) = 100
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
            fixed _Tint;
            float _Scanlines;

            fixed4 frag (v2f_img i) : SV_Target
            {
                fixed3 renderTex = tex2D(_MainTex, i.uv).rgb;
    
                return fixed4(renderTex, 1);

            }
            ENDCG
        }
    }
    FallBack off
}
