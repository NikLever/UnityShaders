Shader "NiksShaders/Shader45Lit"
{
    Properties
    {
        _Radius("Radius", Float) = 1.0
    }
    SubShader
    {
        Tags { "LightMode"="ForwardBase" }
     
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc" // for _LightColor0

            struct v2f
            {
                float4 vertex : SV_POSITION;
                fixed4 diff : COLOR0; // diffuse lighting color
            };
            
            float _Radius;
            float _Delta;

            v2f vert (appdata_base v)
            {
                v2f o;

                float delta = (_SinTime.w + 1.0)/2.0;
                
                float3 normal = normalize(v.vertex.xyz);
                float4 s = float4(normal * _Radius * 0.01, v.vertex.w);
                float4 pos = lerp(v.vertex, s, delta);
                half3 dNormal = lerp(v.normal, normal, delta);

                o.vertex = UnityObjectToClipPos(pos);
                
                // get vertex normal in world space
                half3 worldNormal = UnityObjectToWorldNormal(dNormal);
                
                // dot product between normal and light direction for
                // standard diffuse (Lambert) lighting
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                // factor in the light color
                o.diff = nl * _LightColor0;

                return o;
            }
             
            float4 frag (v2f i) : COLOR
            {
                fixed4 color = 1;
                // multiply by lighting
                color *= i.diff;
                return color;
            }
            ENDCG
        }
    }
}

