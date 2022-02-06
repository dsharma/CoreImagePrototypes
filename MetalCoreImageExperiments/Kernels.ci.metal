//
//  Kernels.ci.metal
//  MetalCoreImageExperiments
//
//  Created by Deepak Sharma on 06/02/22.
//

#include <CoreImage/CoreImage.h>
using namespace metal;

extern "C" float4 passthrough(coreimage::sample_t inputColor)
{
    return inputColor;
}

extern "C" float4 testKernel(coreimage::sampler inputImage, coreimage::destination dest)
{
     float2 inputCoordinate = inputImage.coord();
     float4 color = inputImage.sample(inputCoordinate);
     float2 inputSize = inputImage.size();
     float2 destCoord = dest.coord();

      if (inputCoordinate.x * inputSize.x < destCoord.x || inputCoordinate.y * inputSize.y > destCoord.y) {//
          return float4(0.0, 0.0, 0.0, 1.0);
      }

      return color;
}

extern "C" float4 redKernel(coreimage::sampler inputImage, coreimage::destination dest)
{
    return float4(1.0, 0.0, 0.0, 1.0);
}

