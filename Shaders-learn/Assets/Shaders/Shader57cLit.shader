Shader "NiksShaders/Shader57cLit" {

    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1, 1, 1, 1)

        _OutlineColor ("Outline Color", Color) = (0, 0, 0, 1)
        _OutlineWidth ("Outline Width", Range(0, 0.1)) = 0.03
        _LevelCount("Level Count", Float ) = 3
    }

    Subshader {

        Tags {
            "RenderType" = "Opaque"
        }

        CGPROGRAM

        #pragma surface surf Ramp

        float _LevelCount;
        
        half4 LightingRamp (SurfaceOutput s, half3 lightDir, half atten) {
            half NdotL = dot (s.Normal, lightDir);
            half diff = pow(NdotL * 0.5 + 0.5, 2.0);
            half3 ramp = floor(diff * _LevelCount)/_LevelCount;
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * ramp * atten;
            c.a = s.Alpha;
            return c;
        }

        struct Input {
            float2 uv_MainTex;
        };

        half4 _Color;
        sampler2D _MainTex;
        
        void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = _Color.rgb * tex2D (_MainTex, IN.uv_MainTex).rgb;
        }

        ENDCG

    }

}


