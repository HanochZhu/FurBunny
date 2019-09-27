Shader "Custom/Unlit/FurBunnyWind"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MainColor("Fur Color",Color) = (1.0,1.0,1.0,1.0)
        _Factor("factor",Range(0.8,10)) = 3
        _Speed("wind speed",Range(0.01,1)) = 0.5
        _Force("wind force",Range(0.01,1)) = 0.5
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
            #pragma geometry geom
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal:NORMAL;
                float3 tangent:TANGENT;
            };

            struct v2g
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal:NORMAL;
                float3 tangent:TANGENT;
            };

            struct g2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal:NORMAL;
                float4 furColor:TEXCOORD1;
                float height:TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Factor;
            float4 _MainColor;
            float _Speed;
            float _Force;

            v2g vert(appdata v)
            {
                v2g o;
                
                o.vertex = v.vertex;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.normal = v.normal;
                //UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
            //triangle: specify processing type
            [maxvertexcount(9)]
            void geom(triangle v2g intri[3],inout TriangleStream<g2f> triStream)
            {
                float curTime = _Time.y * _Speed;

                g2f center;
                float3 tangent = (intri[0].tangent + intri[1].tangent + intri[2].tangent) / 3.0;
                center.vertex = (intri[0].vertex + intri[1].vertex + intri[2].vertex) / 3.0;
                center.normal = (intri[0].normal + intri[1].normal + intri[2].normal) / 3.0;
                float excitation = 0.0001 * _Factor;
                float et = sin(curTime) * 0.0001 * _Force;
                center.vertex.x = center.vertex.x + center.normal.x * excitation + et;
                center.vertex.y = center.vertex.y + center.normal.y * excitation;
                center.vertex.z = center.vertex.z + center.normal.z * excitation;
                center.vertex = UnityObjectToClipPos(center.vertex);

                center.height = _Factor;

                center.uv = (intri[0].uv + intri[1].uv + intri[2].uv) / 3;
                center.furColor = float4(1,1,1,1);
                //------------first triangle
                g2f v0;
                v0.vertex = UnityObjectToClipPos(intri[0].vertex);
                v0.normal = intri[0].normal;
                v0.uv = intri[0].uv;
                v0.furColor = _MainColor;
                v0.height = float4(0,0,0,0);

                g2f v1;
                v1.vertex = UnityObjectToClipPos(intri[1].vertex);
                v1.normal = intri[1].normal;
                v1.uv = intri[1].uv;
                v1.furColor = _MainColor;
                v1.height = float4(0,0,0,0);

                g2f v2;
                v2.vertex = UnityObjectToClipPos(intri[2].vertex);
                v2.normal = intri[2].normal;
                v2.uv = intri[2].uv;
                v2.furColor = _MainColor;
                v2.height = float4(0,0,0,0);


                triStream.Append(center);
                triStream.Append(v1);
                triStream.Append(v0);


                triStream.Append(center);
                triStream.Append(v2);
                triStream.Append(v1);

                
                triStream.Append(center);
                triStream.Append(v0);
                triStream.Append(v2);

                triStream.RestartStrip();
            }

    
            fixed4 frag (g2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);

                float height = 1.0 - i.vertex.y;
                // apply fog
                // UNITY_APPLY_FOG(i.fogCoord, col);
                return i.furColor;
                //return float4(i.height,0,0,1);
            }
            ENDCG
        }
    }
}
