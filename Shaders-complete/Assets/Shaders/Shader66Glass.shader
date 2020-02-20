Shader "NiksShaders/Shader66Glass" 
{
    Properties 
    {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
        _Colour ("Colour", Color) = (1,1,1,1)
 
        _BumpMap ("Bump Map", 2D) = "bump" {}
        _Magnitude ("Magnitude", Range(0,1)) = 0.05
        _TintStrength("Tint Strength", Range(0, 1) ) = 0.3
        _EnvironmentMap("Environment Map", CUBE ) = "cube" {}
        _ReflectionStrength("Reflection Strength", Range(0, 1)) = 0.3
    }
 
    SubShader
    {
        Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Opaque"}

        ZWrite On
        Lighting Off
        Cull Off
        Fog { Mode Off } Blend One Zero
 
        GrabPass { "_GrabTexture" }
 
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
 
            sampler2D _GrabTexture;
            sampler2D _MainTex;
            samplerCUBE _EnvironmentMap;
            float _ReflectionStrength;
            fixed4 _Colour;
            sampler2D _BumpMap;
            float  _Magnitude;
            float _TintStrength;
 
            struct appdata
            {
                float4 vertex : POSITION;
                float4 color : COLOR;
                float2 texcoord : TEXCOORD0;
                float3 normal: NORMAL;
            };
 
            struct v2f
            {
                float4 vertex : POSITION;
                fixed4 color : COLOR;
                float2 uv : TEXCOORD0;
                float4 uvgrab : TEXCOORD1;
                float3 reflect: TEXCOORD2;
            };
 
            // Vertex function 
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
 
                o.uv = v.texcoord;
                o.uvgrab = ComputeGrabScreenPos(o.vertex);

                // calculate world space reflection vector
                float3 viewDir = WorldSpaceViewDir(v.vertex);
                float3 worldN = UnityObjectToWorldNormal(v.normal);
                o.reflect = reflect(-viewDir, worldN);

                return o;
            }
 
            // Fragment function
            fixed4 frag (v2f i) : COLOR
            {
                fixed4 maincol = lerp(tex2D(_MainTex, i.uv), _Colour, _TintStrength);
                
                half4 bump = tex2D(_BumpMap, i.uv);
                half2 distortion = UnpackNormal(bump).rg;
 
                i.uvgrab.xy += distortion * _Magnitude;
                fixed4 grabcol = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD(i.uvgrab));

                fixed4 reflcol = texCUBE(_EnvironmentMap, i.reflect);
                reflcol *= maincol.a;
                reflcol *= _ReflectionStrength;

                return grabcol * maincol * _Colour + reflcol;
            }
 
            ENDCG
        } 
    }
}
