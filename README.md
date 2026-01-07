# ZX Spectrum Tools Docker Image

A Docker image containing various tools for building ZX Spectrum software.

## Included Tools

### Assemblers
- **[sjasmplus](https://github.com/z00m128/sjasmplus)** - SjASMPlus Z80 Cross-Assembler

### Compression Tools
- **[zx0](https://github.com/einar-saukas/ZX0)** - Optimal data compressor by Einar Saukas
- **[lzsa](https://github.com/emmanuel-marty/lzsa)** - A lossless data compression tool by Emmanuel Marty and spke
- **[mhmt](https://github.com/lvd2/mhmt)** - MeHruMsT - MEgalz, HRUM and hruST packer/unpacker

### Disk Image Tools
- **[mctrd](https://github.com/samstyle/mctrd)** - A tool for working with ZX Spectrum disk images (TRD, SCL, TAP formats)

### Audio/Music Tools
- **[zxtune123](https://github.com/vitamin-caig/zxtune)** - A chiptune conversion utility supporting various tracker formats
- **[psg_compressor](https://github.com/vasilenkoroman/psg_compressor)** - A tool to pack PSG files

### [Fuse Emulator Utilities](https://github.com/Loxrie/fuse-emulator-utils)
- **createhdf** - Create hard disk image
- **fmfconv** - FMF converter
- **listbasic** - List BASIC programs
- **profile2map** - Convert profile to map
- **raw2hdf** - Convert raw data to HDF
- **rzxcheck** - RZX file checker
- **rzxdump** - RZX file dumper
- **rzxtool** - RZX utility tool
- **scl2trd** - Convert SCL to TRD format
- **snap2tzx** - Convert snapshots to TZX format
- **snapconv** - Snapshot converter
- **tape2pulses** - Convert tape to pulses
- **tapeconv** - Tape converter
- **tzxlist** - TZX file lister

### Build System Support
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
