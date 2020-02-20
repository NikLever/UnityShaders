Shader "NiksShaders/Shader44Unlit"
{
    Properties
    {
        _Radius("Radius", Float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
     
        LOD 100

        Pass
        {
            CGPROGRAM
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members position)
#pragma exclude_renderers d3d11
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };
            
            float _Radius;
            float _Delta;

            v2f vert (appdata_base v)
            {
                v2f o;

                float delta = (_SinTime.w + 1.0)/2.0;
                
                float4 s = float4(normalize(v.vertex.xyz)*_Radius*0.01, v.vertex.w);
                float4 pos = lerp(v.vertex, s, delta);

                o.vertex = UnityObjectToClipPos(pos);

                return o;
            }
             
            float4 frag (v2f i) : COLOR
            {
                return fixed4( 1,1,1,1 );
            }
            ENDCG
        }
    }
}

