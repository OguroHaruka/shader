Shader "Unlit/02_Lambert"
{
    Properties
    {
        _Color("Color",Color) = (1,0,0,1)
    }
    SubShader
    {
       
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"

             fixed4 _Color;

             fixed4 frag (float4 i:SV_POSITION) : SV_TARGET
            {
                fixed4 o = _Color;
                return o;
            }

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float intensity = saturate(dot(normalize(i.normal),_WorldSpaceLightPos0));
                fixed4 diffuse=_Color * intensity * _LightColor0;
                return diffuse;
            }
            ENDCG
        }
    }
}
