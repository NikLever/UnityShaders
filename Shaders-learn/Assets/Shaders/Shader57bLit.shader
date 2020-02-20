Shader "NiksShaders/Shader57bLit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _Color("Color", Color) = (1,1,1,1)
      _Roughness("Roughness", Range(0,1)) = 0.5
      _LevelCount("Level Count", Float ) = 3
      _SpecPower("Specular Power", Range(0,1)) = 0.5
      _SpecColor("Specular Color", Color) = (1,1,1,1)
      _Glossiness("Glossiness", Range(0,1)) = 1
    }

    SubShader {
      
    Tags { "RenderType" = "Opaque" }
      
    CGPROGRAM
      
    #pragma surface surf Ramp

	float _SpecPower;
	float _Glossiness;
	float _Roughness;
	float _LevelCount;
	fixed4 _Color;
	
    half4 LightingSimpleLambert (SurfaceOutput s, half3 lightDir, half atten) {
        half NdotL = max(0, dot (s.Normal, lightDir));
        half4 c;
        c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
        c.a = s.Alpha;
        return c;
    }
    
    half4 LightingHalfLambert (SurfaceOutput s, half3 lightDir, half atten) {
       	half NdotL = max(0, dot(s.Normal, lightDir));
		half diff = pow(NdotL * 0.5 + 0.5, 2.0);
		half4 c;
        c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten);
        c.a = s.Alpha;
        return c;
    }
    
    half4 LightingPhong (SurfaceOutput s, half3 lightDir, half viewDir, half atten){
		half3 lightReflectDir = reflect( -lightDir, s.Normal );
		half NdotL = max(0, dot( s.Normal, lightDir ));
		half RdotV = max(0, dot( lightReflectDir, viewDir ));
		
		//Specular calculations
		half3 specularity = pow(RdotV, _Glossiness * 10)*_SpecPower *_SpecColor.rgb ;

		half3 lightingModel = NdotL * _Color + specularity;
		float3 attenColor = atten * _LightColor0.rgb;
		half4 c;
		c.rgb = s.Albedo * lightingModel * attenColor;
		c.a = s.Alpha;
		return c;
	}
	
	half4 LightingMyBlinnPhong (SurfaceOutput s, half3 lightDir, half viewDir, half atten){
		float3 halfDir = normalize(viewDir + lightDir); 
		half NdotL = max(0, dot( s.Normal, lightDir ));
		half NdotV = max(0, dot( s.Normal, halfDir ));
		
		//Specular calculations
		half3 specularity = pow(NdotV, _Glossiness*20)*_SpecPower*2 *_SpecColor.rgb ;

		half3 lightingModel = NdotL * _Color + specularity;
		float3 attenColor = atten * _LightColor0.rgb;
		half4 c;
		c.rgb = s.Albedo * lightingModel * attenColor;
		c.a = s.Alpha;
		return c;
	}
	
    half4 LightingMinnaert (SurfaceOutput s, half3 lightDir, half viewDir, half atten) {
		half NdotL = max(0, dot( s.Normal, lightDir ));
		half NdotV = max(0, dot( s.Normal, viewDir ));
		half3 minnaert = saturate(NdotL * pow(NdotL*NdotV, _Roughness));
		half4 c;
		c.rgb = s.Albedo * _LightColor0.rgb * atten * minnaert;
		c.a = s.Alpha;
		return c;
	}
	
	half4 LightingOrenNayer (SurfaceOutput s, half3 lightDir, half viewDir, half atten) {
		half roughness = _Roughness;
     	half roughnessSqr = roughness * roughness;
     	half3 ONFraction = roughnessSqr / (roughnessSqr + float3(0.33, 0.13, 0.09));
     	float3 ON = float3(1, 0, 0) + float3(-0.5, 0.17, 0.45) * ONFraction;
     	float NdotL = saturate(dot(s.Normal, lightDir));
     	float NdotV = saturate(dot(s.Normal, viewDir));
     	float ONs = saturate(dot(lightDir, viewDir)) - NdotL * NdotV;
     	ONs /= lerp(max(NdotL, NdotV), 1, step(ONs, 0));

     	//lighting and final diffuse
     	half3 lightingModel = _Color * NdotL * (ON.x + _Color * ON.y + ON.z * ONs);
     	half3 attenColor = atten * _LightColor0.rgb;
     	half4 c;
     	c.rgb = s.Albedo * lightingModel * attenColor;
        c.a = s.Alpha;
        return c;
    }
    
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
      
      sampler2D _MainTex;
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}

