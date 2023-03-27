# Overview

- This project implementation of the `Limpel_Ziv77(LZ77) Compression and Decompression` algorithm and was devoloped by 2 teams of 5 students each, one for the Compression and the other for the Decompression.

- The architecture is made in a `13-bit` format so that the outputted data is in the from of `13-bit` divided as follows; `3 bits` for the IP, `2 bits` for the Lmax, and `8 bits` for the byte that should enter the window.

---

## Technologies

- `VHDL 98`
- `ISE Design Suite 14.6 (The only software that our university could provide)` 

---

## How to run

- To run the project simply open it with ISE design suite click on simulation then click on the testbench of the compression_chip and put the input that you want then run the test bench. Then after running the test bench take the output from the console and put it in the test bench of the decompression and the original steam of bytes should be outputted.

---

## Results

A [Final Report](https://github.com/AbduEhab/LZ77-VHDL/blob/main/FINAL_REPORT/DSD%20ProJect%20Report.pdf) can be found, along with many charts) in the [Final Report folder](https://github.com/AbduEhab/LZ77-VHDL/tree/main/FINAL_REPORT).

## Compression

![circuit_diagram_image compression](https://github.com/AbduEhab/LZ77-VHDL/blob/main/FINAL_REPORT/circuit_diagram_image%20compression.png)
![Compression test](https://github.com/AbduEhab/LZ77-VHDL/blob/main/FINAL_REPORT/testbenchcompression.PNG)

## Decompression

![DeCompressionRTL](https://github.com/AbduEhab/LZ77-VHDL/blob/main/FINAL_REPORT/DeCompressionRTL.PNG)
![Decompression test](https://github.com/AbduEhab/LZ77-VHDL/blob/main/FINAL_REPORT/Decompressiontestbench.PNG)
