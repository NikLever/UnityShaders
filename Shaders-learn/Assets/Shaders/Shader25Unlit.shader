Shader "NiksShaders/Shader25Unlit"
{
    Properties
    {
        _BrickColor("Brick Color", Color) = (0.9, 0.3, 0.4, 1)
        _MortarColor("Mortar Color", Color) = (0.7, 0.7, 0.7, 1)
        _TileCount("Tile Count", Int) = 10
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
            
            fixed4 _BrickColor;
            fixed4 _MortarColor;
            int _TileCount;

            float brick(float2 pt, float mortar_height, float edge_thickness){
                if (pt.y>0.5) pt.x = frac(pt.x + 0.5);
                float half_mortar_height = mortar_height/2.0;
                //Draw bottom line
                float result = 1 - smoothstep(half_mortar_height, half_mortar_height + edge_thickness, pt.y);
                //Draw top line
                result += smoothstep(1.0 - half_mortar_height - edge_thickness, 1.0 - half_mortar_height, pt.y);
                //Draw middle line
                result += smoothstep(0.5 - half_mortar_height - edge_thickness, 0.5 - half_mortar_height, pt.y) - smoothstep(0.5 + half_mortar_height, 0.5 + half_mortar_height + edge_thickness, pt.y);
                //Draw vertical lines
                result += smoothstep(-half_mortar_height - edge_thickness, -half_mortar_height, pt.x) - smoothstep(half_mortar_height, half_mortar_height + edge_thickness, pt.x) + smoothstep(1.0-half_mortar_height-edge_thickness, 1.0-half_mortar_height, pt.x);
                
                return result;
            }
            
            fixed4 frag (v2f_img i) : SV_Target
            {
                float2 uv = frac(i.uv * _TileCount);
                fixed3 color = brick(uv, 0.05, 0.001) * fixed3(1.0, 1.0, 1.0); 
                
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
