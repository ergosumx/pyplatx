Downloads NVIDIA cuDNN and provides configuration to `.pyplatx`.

### Instructions for downloading NVIDIA cuDNN
1. Go to the NVIDIA cuDNN website (https://developer.nvidia.com/rdp/cudnn-download)
2. Select the appropriate version for your operating system (e.g., Ubuntu 20.04)
3. Download the cuDNN package (deb file) to your local machine
4. Copy the downloaded deb file to the specified paths in the cudnn_files list

### Configuration instructions for .pyplatx
1. Open the .pyplatx file in a text editor
2. Locate the section for configuring cuDNN
3. Update the paths in the configuration to match the paths of the downloaded cudnn files
4. Save the changes to the .pyplatx file

### Example

```
cudnn_files = [
  "./nvidia/cudnn/ubuntu2204-8.9.5.30_11-8_amd64.deb",
  "./nvidia/cudnn/ubuntu2204-8.9.5.30-12-2_amd64.deb"
]
```