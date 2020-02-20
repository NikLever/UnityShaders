Shader "NiksShaders/Shader63aLit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader {
      
      Tags { "Queue" = "Geometry" }

      Stencil{
        Ref 1
        Comp notequal
        Pass keep
      }

	  Cull Back
	  
      CGPROGRAM
      
      #pragma surface surf Lambert
      
      struct Input {
          float2 uv_MainTex;
      };
      
      sampler2D _MainTex;
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
      }
      
      ENDCG
      
      Stencil{
        Ref 1
        Comp always
        Pass keep
      }
      
      Cull Front
	  
      CGPROGRAM
      
      #pragma surface surf Lambert
      
      struct Input {
          float2 uv_MainTex;
      };
      
      sampler2D _MainTex;
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
