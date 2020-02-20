Shader "NiksShaders/Shader65Lit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _AlphaTest ("Alpha Test", Float) = 0.7
    }

    SubShader {
      
      Tags { "RenderType" = "Opaque"}

      CGPROGRAM
      
      #pragma surface surf Lambert
      
      // Use shader model 3.0 target, to get nicer looking lighting
      #pragma target 3.0

      struct Input {
          float2 uv_MainTex;
      };
      
      sampler2D _MainTex;
      
      void surf (Input IN, inout SurfaceOutput o) {
          fixed4 col = tex2D (_MainTex, IN.uv_MainTex);
          o.Albedo = col.rgb;
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
