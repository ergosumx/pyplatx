# PyPlatX: CUDA/cuDNN Installer

This script automates installing multiple versions of CUDA and cuDNN on Ubuntu.

## Features

- Install multiple CUDA toolkits
- Install multiple cuDNN versions 
- Configure environment for active CUDA/cuDNN version
- Specify versions in a config file
- Handles NVIDIA driver installation
- Validates installation

## Usage

**Install**

```bash
git clone https://github.com/user/cuda-installer
cd cuda-installer
sudo ./install.sh
```

**Config File (default is `.pyplatx`)**

```yaml  
cuda:

  toolkit:
    - "11-8" 
    - "12-2"

  cudnn:
    - "/path/to/cudnn-11-8.deb"
    - "/path/to/cudnn-12-2.deb"
  
  active:  
    toolkit: "11-8"
    cudnn: "/path/to/cudnn-11-8.deb"
```

**Command Line Options**

```
usage: install.sh [-h] [-f CONFIG_FILE]  
```

```
Optional arguments:
  -h, --help            Show this help message and exit

  -f CONFIG_FILE, --file CONFIG_FILE  
                        Path to config file
```

## License

This project is licensed under the MIT license - see the [LICENSE](LICENSE) file for more details.

Let me know if you need any other sections or have additional questions!