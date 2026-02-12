import numpy as np
import cv2

# Load edge output
edge = np.loadtxt("C:\\Users\\94772\\Desktop\\university tools\\SEMESTER 7\\EE587-Digital Design and Synthesis\\Sobel Edge Detector\\edge_output.txt")

# Reshape correctly
edge = edge.reshape(510, 510)

# Convert to uint8
edge = np.clip(edge, 0, 255)
edge = edge.astype(np.uint8)

# Save image
cv2.imwrite("sobel_output.jpg", edge)

print("Edge image saved successfully.")
