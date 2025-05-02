Shader "NiksShaders/Shader46aUnlit"
{
    Properties
    {
        _Scale("Scale", Range(0.1, 3)) = 1
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }

        LOD 100

        Pass
        {
            CGPROGRAM
            //#pragma exclude_renderers d3d11
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Assets/includes/noiseSimplex.hlsl"

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv: TEXCOORD0;
                float4 noise: TEXCOORD1;
            };

            float _Scale;

            v2f vert (appdata_base v)
            {
                v2f o;

                o.noise = 0;
                o.noise.x = 10.0 * -0.1 * turbulence(0.5 * v.normal);
                float3 size = 100.0;
                float b = _Scale * 0.5 * pnoise(0.05 * v.vertex + _Time.y, size);
                float displacement = b - _Scale * o.noise.x;
                float3 newPosition = v.vertex + v.normal * displacement;
                o.pos = UnityObjectToClipPos(newPosition);
                o.uv = v.texcoord;
                 
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed3 color = fixed3( i.uv * ( 1. - 2. * i.noise.x ), 0.0 );
                return fixed4( color, 1 );
            }

            ENDCG

        }

    }

    Fallback "Diffuse"

}
