Shader "NiksShaders/Shader54Lit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _Cube ("Cubemap", CUBE) = "" {}
    }

    SubShader {
      
      Tags { "RenderType" = "Opaque" }
      
      CGPROGRAM
      
      #pragma surface surf Lambert
      
      struct Input {
          float2 uv_MainTex;
          float3 worldRefl;
      };
      
      sampler2D _MainTex;
      samplerCUBE _Cube;
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * 0.5;
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
