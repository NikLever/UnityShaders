Shader "NiksShaders/Shader51Lit"
{
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {

        Tags { "RenderType" = "Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;

        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = 1;
        }
        ENDCG
    }

    Fallback "Diffuse"
}
