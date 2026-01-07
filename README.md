# ZX Spectrum Tools Docker Image

A Docker image containing various tools for building ZX Spectrum software.

## Included Tools

- **[sjasmplus](https://github.com/z00m128/sjasmplus)** - A modern Z80 assembler
- **[zx0](https://github.com/einar-saukas/ZX0)** - A high-ratio compressor
- **[fuse-emulator-utils](https://github.com/Loxrie/fuse-emulator-utils)** - A collection of ZX Spectrum emulator utilities
- **[mctrd](https://github.com/samstyle/mctrd)** - A TRD disk image manipulation tool
- **[mhmt](https://github.com/lvd2/mhmt)** - MegaLZ, Hrum and Hrust packer/unpacker
- **[lzsa](https://github.com/emmanuel-marty/lzsa)** - A lossless data compression tool
- **[zxtune](https://github.com/vitamin-caig/zxtune)** - Chiptunes player and tracker files utility (zxtune123)
- **[make](https://www.gnu.org/software/make/)** - Makefile build system support

## Usage

### Using the image in your GitHub Actions workflow

Create a `.github/workflows/build.yml` file in your project repository:

```yaml
name: Build ZX Spectrum Project

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/alexanderk23/zx-tools-image:latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Build project
      run: |
        sjasmplus source.asm

    - name: Upload artifacts
      uses: actions/upload-artifact@v4
      with:
        name: zx-spectrum-build
        path: output.tap
```

### Building the image locally

```bash
docker build -t zx-tools-image .
```

## Contributing

Feel free to submit issues or pull requests to improve this image.
