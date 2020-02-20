Shader "NiksShaders/Shader65Lit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _AlphaTest ("Alpha Test", Range(0,1)) = 0.7
    }

    SubShader {
      
      Tags { "RenderType" = "Transparent" "Queue"="Transparent"}

      ZWrite off

      CGPROGRAM
      
      #pragma surface surf Lambert alpha:fade noshadow
      
      struct Input {
          float2 uv_MainTex;
      };
      
      sampler2D _MainTex;
      
      void surf (Input IN, inout SurfaceOutput o) {
          fixed4 col = tex2D (_MainTex, IN.uv_MainTex);
          o.Albedo = col.rgb;
          o.Alpha = 1 - col.a;
      }
      
      ENDCG
      
      ColorMask 0
      
      CGPROGRAM
      
      #pragma surface surf Lambert alpha:fade alphatest:_AlphaTest addshadow
      
      struct Input {
          float2 uv_MainTex;
      };
      
      sampler2D _MainTex;
      
      void surf (Input IN, inout SurfaceOutput o) {
          fixed4 col = tex2D (_MainTex, IN.uv_MainTex);
          o.Albedo = col.rgb;
          o.Alpha = 1 - col.a;
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
