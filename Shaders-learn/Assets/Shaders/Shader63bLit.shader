Shader "NiksShaders/Shader63bLit"
{
    Properties {
    }

    SubShader {
      
      Tags { "Queue" = "Geometry" }
      
      CGPROGRAM
      
      #pragma surface surf Lambert
      
      struct Input {
          float3 worldPos;//Because empty Input causes an error
      };
      
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = fixed4(1,1,1,1);
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
