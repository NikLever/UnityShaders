Shader "NiksShaders/Shader57bLit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _LevelCount("LevelCount", Float) = 4
    }

    SubShader {
      
    Tags { "RenderType" = "Opaque" }
      
    CGPROGRAM
      
    #pragma surface surf Ramp noshadow

    sampler2D _MainTex;
    float _LevelCount;

    half4 LightingRamp (SurfaceOutput s, half3 lightDir, half atten) {
        half NdotL = dot (s.Normal, lightDir);
        half diff = NdotL * 0.5 + 0.5;
        half3 ramp = floor(diff * _LevelCount)/_LevelCount;
        half4 c;
        c.rgb = s.Albedo * _LightColor0.rgb * ramp * atten;
        c.a = s.Alpha;
        return c;
    }

      struct Input {
          float2 uv_MainTex;
      };
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
