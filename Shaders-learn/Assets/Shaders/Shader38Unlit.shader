Shader "NiksShaders/Shader38Unlit"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
     
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag

            #include "UnityCG.cginc"
          
            sampler2D _MainTex;

            float4 frag (v2f_img i) : COLOR
            {
                fixed3 color = length(i.uv);

                return fixed4( color, 1.0 );
            }
            ENDCG
        }
    }
}

