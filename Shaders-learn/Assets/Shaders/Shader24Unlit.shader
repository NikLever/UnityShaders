Shader "NiksShaders/Shader24Unlit"
{
    Properties
    {
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
            
            float brick(float2 pt, float mortar_height, float edge_thickness){
                float result = 0;
                return result;
            }
            
            fixed4 frag (v2f_img i) : SV_Target
            {
                fixed3 color = brick(i.uv, 0.05, 0.001) * fixed3(1.0, 1.0, 1.0); 
                
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
