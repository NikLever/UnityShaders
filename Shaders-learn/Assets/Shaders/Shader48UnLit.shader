Shader "NiksShaders/Shader48Unlit"
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
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "noiseSimplex.cginc"

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
                // add time to the noise parameters so it's animated
                o.noise = 0;
                // get a turbulent 3d noise using the normal, normal to high freq
                o.noise.x = 10.0 *  -0.10 * turbulence( 0.5 * v.normal + _Time.y );
                // get a 3d noise using the position, low frequency
                float3 size = 100;
                float b = _Scale * 0.5 * pnoise( 0.05 * v.vertex + _Time.y, size );
                float displacement = b - _Scale * o.noise.x;

                // move the position along the normal and transform it
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
}

