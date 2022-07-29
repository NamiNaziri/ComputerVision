# ComputerVision


## Custom Rotation
  
A small program that allows you to rotate an image. The goal of this program was to rotate a picture without using helper functions such as imrotate. The implementation uses nearest neighbor interpolation.

<div align="center">

### Result

Original Image             |  Rotated Image by 180 degree
:-------------------------:|:-------------------------:
![](https://user-images.githubusercontent.com/49837425/181776172-3bb714a6-d888-413e-93da-ca7ff4fbba20.png)  |  ![](https://user-images.githubusercontent.com/49837425/181775795-4eae7c66-1d53-402a-8457-fd943d7f7b8d.png)

</div>

## Floyd–Steinberg dithering

An implementation of Floyd–Steinberg dithering algorithm to create black and white image ([Wikipedia](https://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering))

<div align="center">

### Result

Original Image             |  Floyd–Steinberg dithering
:-------------------------:|:-------------------------:
![](https://user-images.githubusercontent.com/49837425/181779457-3ab3e2e2-3023-4655-b278-893ec844d29f.png)  |  ![](https://user-images.githubusercontent.com/49837425/181779476-d0455374-5660-456a-bb0d-6889fca62b7d.png)

</div>

  
## Custom Resize

A small program that allows you to resize an image. The goal of this program was to resize a picture without using helper functions such as imresize. The implementation uses bilinear interpolation.

<div align="center">

### Result

Original Image             |  Resized Image by 0.6
:-------------------------:|:-------------------------:
![House](https://user-images.githubusercontent.com/49837425/181781516-a29f5cca-2685-458b-83bd-722395e81d64.png) |  ![resizedImage](https://user-images.githubusercontent.com/49837425/181781540-7eafb89e-eaef-4f4d-815f-94cdd3e48eaf.png)

</div>

## Improved 2x resizing 

An improvement to Bicubic interpolation for creating resized image of 2. 

### Solution

My suggested method is inspired by "Directional Cubic Convolution Interpolation" ([Wikipedia](https://en.wikipedia.org/wiki/Directional_Cubic_Convolution_Interpolation)). Consider the following image, The orange squares are the original pixels from the small image. First I calculate the purple circle using the 4 orange squares surrounding it. then in the next iteration, I Calculate other circles using 2 orange squares and 2 purple circles surrounding them.

<div align="center">

![ex](https://user-images.githubusercontent.com/49837425/181784528-8bfe836d-84d4-4f49-a2b1-fe87c418dd0a.png)



### Result

![table](https://user-images.githubusercontent.com/49837425/181783830-a506f833-09df-4331-a1c6-cdb1c81e983f.png)

</div>



