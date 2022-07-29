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

## Find The Sum of the Numbers In Image
Find the sum of numbers in the image, considering the sign of red numbers as positive and blue numbers as negative.

### Solution

To solve this problem, I first denoise the picture using a median filter. After that by scanning horizontally and vertically, the location of the numbers can be found. Next, the numbers are compared to the numbers in the ground truth database in order to find the best match (Using MSE). The results are in the green at the bottom of the output picture.

A 98 percent accuracy rate is achieved by the current program.

Note: The numbers in the image are in farsi.

<div align="center">
  
![English-numbers-and-their-Persian-equivalents](https://user-images.githubusercontent.com/49837425/181790042-e415d9b7-5fda-48b0-9f43-60b757e3a1ed.png)

### Result

![Image_12_28](https://user-images.githubusercontent.com/49837425/181790172-02e347c6-2040-429d-b0f0-49c7ef74a1fa.png)
  
  </div>

## Improved method for reducing salt and pepper noise 

A method to improve median filter for reducing salt and pepper noise.

### Solution

Since the salt and pepper noise produces pixels of zeros and ones then we know which pixels are the noise. A kernel of 3 by 3 is used and moved along the image. To calculate the current pixel, we consider its neighboring pixels in the kernel and average those that are not zero or one. If all of the neighboring pixels are zero or one, then we just use a simple median.


<div align="center">
  

### Result

  Original Image             | 70 percent salt and pepper |  median filter |  Suggested method
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![I](https://user-images.githubusercontent.com/49837425/181793625-c715ab95-73fa-428e-9a19-f78a4b8baa98.png) |  ![j](https://user-images.githubusercontent.com/49837425/181793641-49172138-29bd-4402-a3e7-f3eefc89972b.png) |  ![med](https://user-images.githubusercontent.com/49837425/181793766-83c3c744-7002-4c22-b712-4cbe8900047a.png) | ![finalPic](https://user-images.githubusercontent.com/49837425/181793825-a4e93c99-d349-413b-b54d-64b84ebe66ac.png)
  




  

  </div>
