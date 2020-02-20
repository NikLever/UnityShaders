Shader "NiksShaders/RotatingRectangles"
{
    Properties
    {
        _TileCount ("TileCount", int) = 6
        _BgColor("BackgroundColor", Color) = (0,0,0,1)
        _TileColor ("TileColor", Color) = (1,1,0,1)
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

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            int _TileCount;
            fixed4 _BgColor;
            fixed4 _TileColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float inRect(float2 pt, float2 anchor, float2 size, float2 center){
              //return 0 if not in rect and 1 if it is
              //step(edge, x) 0.0 is returned if x < edge, and 1.0 is returned otherwise.
              float2 p = pt - center;
              float2 halfsize = size/2.0;
              float horz = step(-halfsize.x - anchor.x, p.x) - step(halfsize.x - anchor.x, p.x);
              float vert = step(-halfsize.y - anchor.y, p.y) - step(halfsize.y - anchor.y, p.y);
              return horz*vert;
            }

            float2x2 getRotationMatrix(float theta){
              float s = sin(theta);
              float c = cos(theta);
              return float2x2(c, -s, s, c);
            }

            float2x2 getScaleMatrix(float scale){
              return float2x2(scale,0,0,scale);
            }

            fixed4 frag (v2f i) : SV_Target
            {
              float tilecount = _TileCount;
              float2 center = float2(0.5, 0.5);
              float2 pt = frac(i.uv*tilecount) - center;
              float2x2 matr = getRotationMatrix(_Time.y);
              float2x2 mats = getScaleMatrix((sin(_Time.y)+1.0)/3.0 + 0.5);
              pt = mul(matr, pt);
              pt = mul(mats, pt);
              pt += center;
              float r = inRect(pt, float2(0.0, 0.0), float2(0.3, 0.3), center);
              float3 color = _TileColor * r + _BgColor * (1.0 - r);
              return fixed4(color, 1.0); 
            }

            ENDCG
        }
    }
}
