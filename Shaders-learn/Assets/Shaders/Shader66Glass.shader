Shader "NiksShaders/Shader66Glass" 
{
    Properties 
    {
        _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
        _Colour ("Colour", Color) = (1,1,1,1)
    }
 
    SubShader
    {
        Tags {"RenderType"="Opaque"}
 
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
 
            sampler2D _MainTex;
            fixed4 _Colour;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float4 color : COLOR;
                float2 texcoord : TEXCOORD0;
            };
 
            struct v2f
            {
                float4 vertex : POSITION;
                fixed4 color : COLOR;
                float2 uv : TEXCOORD0;
            };
 
            // Vertex function 
            v2f vert (appdata v)
            {
                v2f o;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
                o.uv = v.texcoord;
                
                return o;
            }
 
            // Fragment function
            fixed4 frag (v2f i) : COLOR
            {
                fixed4 maincol = tex2D(_MainTex, i.uv);

                return maincol * _Colour;
            }
 
            ENDCG
        } 
    }
}
