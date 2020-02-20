Shader "NiksShaders/Shader55Lit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _BumpMap ("Bumpmap", 2D) = "bump" {}
      _Cube ("Cubemap", CUBE) = "" {}
      _PerPixelReflection("Per Pixel Reflection", Range(0,1)) = 1
    }

    SubShader {
      
      Tags { "RenderType" = "Opaque" }
      
      CGPROGRAM
      
      #pragma surface surf Lambert
      
      struct Input {
          float2 uv_MainTex;
          float2 uv_BumpMap;
          float3 worldRefl;
          INTERNAL_DATA
      };
      
      sampler2D _MainTex;
      sampler2D _BumpMap;
      samplerCUBE _Cube;
      float _PerPixelReflection;
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * 0.5;
          o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
          if (_PerPixelReflection!=0){
          	o.Emission = texCUBE (_Cube, WorldReflectionVector (IN, o.Normal)).rgb;
          }else{
          	o.Emission = texCUBE (_Cube, IN.worldRefl).rgb;
          }
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
