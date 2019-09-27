Shader "Custom/Unlit/FurBunnyMultiLayer"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _NoiseTex ("Noise Texture", 2D) = "white" {}
        _FurLength("Fur Length",Range(0,3)) = 0.05
        _UVScale("UV Scale",Range(0.1,5)) = 1
        _FurAOInstensity("Fur AO Instensity",Range(0,1)) = 0.5
        _FurDensity("Fur Density",Range(0,1)) = 0.5
        _WindSpeed("Wind Speed",Range(0,10)) = 0
        _WindDir("wind dir",vector) = (1,0,0)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 100
        Cull Off
        //Blend SrcColor OneMinusSrcColor
        Blend SrcAlpha OneMinusSrcAlpha
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_base
            #pragma fragment frag_base
            #define STEP 0
            // make fog work
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"
            ENDCG
        }
        pass
        {
            //Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work

            #define STEP 0.05  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
        pass
        {
CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work
            #pragma multi_compile_fog

            #define STEP 0.1  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
        pass
        {
CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work
            #pragma multi_compile_fog

            #define STEP 0.15  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
        pass
        {
CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work
            #pragma multi_compile_fog

            #define STEP 0.2  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
        pass
        {
CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work
            #pragma multi_compile_fog

            #define STEP 0.25  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
        pass
        {
CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work
            #pragma multi_compile_fog

            #define STEP 0.3  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
        pass
        {
CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work
            #pragma multi_compile_fog

            #define STEP 0.35  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
        pass
        {
CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work
            #pragma multi_compile_fog

            #define STEP 0.4  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
        pass
        {
CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work
            #pragma multi_compile_fog

            #define STEP 0.45  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
        pass
        {
CGPROGRAM
            #pragma vertex vert_fur
            #pragma fragment frag_fur
            // make fog work
            #pragma multi_compile_fog

            #define STEP 0.5  // layer of fur
            #include "UnityCG.cginc"
            #include "FurCommon.cginc"

            ENDCG
        }
    
    }
}
