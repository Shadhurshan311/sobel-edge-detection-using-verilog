# 🖼️ Sobel Edge Detection Using Verilog (Simulation-Based Implementation)

## 📌 Project Overview

This project implements the **Sobel Edge Detection algorithm** using **Verilog HDL** for simulation purposes. The system processes a grayscale image stored in a text file, applies the Sobel operator using a 3×3 sliding window architecture, and generates an output text file containing edge-detected pixel values.

The design is intended for:

* Digital Design Laboratories
* FPGA Image Processing Fundamentals
* HDL-based Image Processing Simulation

⚠️ Note: This implementation uses file I/O system tasks (`$fopen`, `$fscanf`, `$fwrite`) and is meant for **simulation only**. It is not synthesizable for FPGA hardware.

---

## 🏗️ System Architecture

```
Input Image (.jpg)
        ↓
Convert to Grayscale
        ↓
Resize (e.g., 512×512)
        ↓
Convert to Text File (input_image.txt)
        ↓
Verilog Simulation (Sobel Processing)
        ↓
edge_output.txt
        ↓
Convert Back to Image (Python)
```

---

## 🧠 Sobel Operator

### Horizontal Gradient (Gx)

```
-1   0  +1
-2   0  +2
-1   0  +1
```

### Vertical Gradient (Gy)

```
-1  -2  -1
 0   0   0
+1  +2  +1
```

Gradient magnitude approximation used:

```
G = |Gx| + |Gy|
```

Values are clamped to 255 to maintain 8-bit range.

---

## 📂 File Structure

```
sobel-edge-detection-using-verilog/
│
├── main.v
├── images
├── natural_decimal.txt
├── edge_output.txt
├── convert_to_txt.py
└── convert_to_image.py
```

---

## ⚙️ Step 1: Convert Image to Text File

Use Python to convert an image into a grayscale text file:

```python
import cv2
import numpy as np

img = cv2.imread("lena.jpg", cv2.IMREAD_GRAYSCALE)
img = cv2.resize(img, (512, 512))

np.savetxt("input_image.txt", img.flatten(), fmt="%d")
```

Ensure:

* One pixel value per line
* No commas or brackets
* Total lines = WIDTH × HEIGHT

---

## ▶️ Step 2: Run Verilog Simulation (Vivado XSim)

1. Place `input_image.txt` in the simulation working directory.
2. Launch Behavioral Simulation.
3. In Tcl console, run:

```
run all
```

⚠️ Do NOT use default `run 1000ns`, as the simulation will stop before processing completes.

---

## 📄 Output File

The simulation generates:

```
edge_output.txt
```

Location:

* Vivado: `project.sim/sim_1/behav/xsim/`

Output image size will be:

```
(WIDTH - 2) × (HEIGHT - 2)
```

Example: 510 × 510 (for 512 × 512 input)

---

## 🖼️ Step 3: Convert Output Text to Image

```python
import numpy as np
import cv2

edge = np.loadtxt("edge_output.txt")
edge = edge.reshape(510, 510)
edge = np.clip(edge, 0, 255)
edge = edge.astype(np.uint8)

cv2.imwrite("sobel_output.jpg", edge)
```

---

## 🧩 Key Design Features

* 3-Line Buffer Architecture
* 3×3 Sliding Window Implementation
* Signed Gradient Computation
* Absolute Value Calculation
* Output Clamping to 8-bit Range

---

## ⏱ Simulation Considerations

Clock Period:

```
10 ns
```

Total Required Simulation Time:

```
WIDTH × HEIGHT × Clock Period
```

Example (512×512):

```
≈ 2.6 ms
```

Always use:

```
run all
```

---

## 🚀 Possible Enhancements

* Add thresholding for binary edge detection
* Implement normalization for improved contrast
* Convert to synthesizable streaming architecture
* Replace file I/O with BRAM-based memory
* Implement pipelined Sobel filter

---

## 🎓 Learning Outcomes

This project demonstrates:

* Hardware-style image processing
* Sliding window implementation in Verilog
* File-based simulation techniques
* Sobel edge detection fundamentals
* Digital signal processing in HDL

---

## 📜 License

This project is intended for academic and educational use.
