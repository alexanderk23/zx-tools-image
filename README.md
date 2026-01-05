# ZX Spectrum Tools Docker Image

A Docker image containing various tools for building ZX Spectrum software.

## Included Tools

- **[sjasmplus](https://github.com/z00m128/sjasmplus)** - A modern Z80 assembler
- **[zx0](https://github.com/einar-saukas/ZX0)** - A high-ratio compressor
- **[fuse-emulator-utils](https://github.com/Loxrie/fuse-emulator-utils)** - A collection of ZX Spectrum emulator utilities
- **[mctrd](https://github.com/samstyle/mctrd)** - A TRD disk image manipulation tool
- **[mhmt](https://github.com/lvd2/mhmt)** - MegaLZ, Hrum and Hrust packer/unpacker
- **[lzsa](https://github.com/emmanuel-marty/lzsa)** - A lossless data compression tool

## Usage

### Building the image

```bash
docker build -t zx-tools .
```

### Using the image

You can use this image in your GitHub Actions workflow:

```yaml
name: Build ZX Spectrum Software
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: alexanderk23/zx-tools:latest
    steps:
    - uses: actions/checkout@v4
    - name: Build project
      run: |
        sjasmplus source.asm
    - name: Compress data
      run: |
        zx0 data.bin data.zx0
    - name: Upload artifacts
      uses: actions/upload-artifact@v3
      with:
        name: zx-spectrum-build
        path: output.tap
```

## Contributing

Feel free to submit issues or pull requests to improve this image.
