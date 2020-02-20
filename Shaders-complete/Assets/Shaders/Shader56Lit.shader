Shader "NiksShaders/Shader56Lit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _SpecColor ("Specular Color", Color) = (1,1,1,1)
      _SpecPower ( "Specular Power" , Range(0,1) ) = 0.5
      _Glossiness ( "Glossiness" , Range(0,1) ) = 1
    }

    SubShader {
      
      Tags { "RenderType" = "Opaque" }
      
      CGPROGRAM
      
      #pragma surface surf BlinnPhong
      
      struct Input {
          float2 uv_MainTex;
      };
      
      sampler2D _MainTex;
      float _SpecPower;
      float _Glossiness;
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
          o.Specular = _SpecPower ;
          o.Gloss = _Glossiness ;
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
