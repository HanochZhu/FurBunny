sampler2D _MainTex;
sampler2D _NoiseTex;
float4 _MainTex_ST;
float4 _NoiseTex_ST;
float _FurLength;
float _UVScale;
float _FurAOInstensity;
float _FurDensity;
float _WindSpeed;
float3 _WindDir;

struct appdata
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
    float3 normal:NORMAL;
};

struct v2f
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float3 normal:TEXCOORD1;
};

v2f vert_base (appdata v)
{
    v2f o;
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    o.vertex = UnityObjectToClipPos(v.vertex);
    return o;
}

fixed4 frag_base (v2f i) : SV_Target
{
    // sample the texture
    fixed4 col = tex2D(_MainTex, i.uv);
    // apply fog
    return col;
}

v2f vert_fur (appdata v)
{
    v2f o;
    float3 newpos = v.vertex.xyz + v.normal * _FurLength * STEP;

    float k = pow(STEP,3);
    float4 objGravity = mul(unity_ObjectToWorld ,float3(0,-0.5,0));
    float4 pos = float4((newpos + (objGravity + sin(_WindSpeed * _Time.y) * _WindDir * 0.9) * k),1.0);

    o.vertex = UnityObjectToClipPos(pos);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);// * _UVScale;
    o.normal = normalize(mul(unity_WorldToObject,v.normal));
    return o;
}

fixed4 frag_fur (v2f i) : SV_Target
{
    // sample the texture
    fixed4 noisecol = tex2D(_NoiseTex, i.uv);
    fixed4 maincol = tex2D(_MainTex, i.uv);
    maincol.rgb -= (pow(1 - STEP , 3)) * _FurAOInstensity;
    
    fixed grey = (noisecol.r + noisecol.g + noisecol.b) / 3.0;
    grey = clamp(grey * _FurDensity * (2 - pow(STEP,2) * 4),0,1);
    // fixed alpha = clamp(noisecol.a * _FurDensity * (2 - STEP * 4),0,1);
    return float4(maincol.rgb,grey);
}
