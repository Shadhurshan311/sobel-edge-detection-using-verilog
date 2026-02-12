import cv2
import numpy as np

img = cv2.imread("C:\\Users\\94772\\Desktop\\university tools\\SEMESTER 7\\EE587-Digital Design and Synthesis\\Sobel Edge Detector\\nature.jpg", cv2.IMREAD_GRAYSCALE)
img = cv2.resize(img, (512,512))

np.savetxt("nature_decimal.txt", img.flatten(), fmt="%d")
