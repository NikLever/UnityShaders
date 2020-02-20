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
                fixed3 tintColor = fixed3( 0.6, 1, 0.6 );
                fixed3 grayScale = (renderTex.r + renderTex.g + renderTex.b) / 3;
                fixed3 tinted = grayScale * tintColor;
                fixed3 finalColor = lerp(renderTex, tinted, _Tint);
                
                float scanline = smoothstep(0.2, 0.4, frac(i.uv.y * _Scanlines));
                finalColor = lerp(fixed3(0,0,0), finalColor, scanline);
            
                
                return fixed4(finalColor, 1);

            }
            ENDCG
        }
    }
    FallBack off
}
