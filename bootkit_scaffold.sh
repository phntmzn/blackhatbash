#!/bin/bash

PROJECT="mac_efi_bootkit"
echo "[+] Creating project: $PROJECT"

# Create base structure
mkdir -p $PROJECT/{bootkit,tools,data/known_efi_binaries,tests,docs,scripts}

# Touch main Python modules
touch $PROJECT/bootkit/{__init__.py,builder.py,efi_payload.asm,efi_payload.bin,injector.py,uefi_structs.py,fs_utils.py}
touch $PROJECT/tools/{nasm_compile.py,esp_extractor.py,device_info.py}
touch $PROJECT/tests/{test_uefi_structs.py,test_injection.py,test_fs_utils.py}
touch $PROJECT/docs/{architecture.md,safety_guidelines.md}
touch $PROJECT/scripts/{build_bootkit.sh,launch_vm.sh}

# Create meta files
cat <<EOF > $PROJECT/README.md
# mac_efi_bootkit

Educational EFI bootkit project for macOS. Includes shellcode builder, ESP injector, and FAT32 parser.

⚠️ WARNING: For educational use only on authorized systems.
EOF

cat <<EOF > $PROJECT/requirements.txt
pyfatfs
pyobjc-framework-DiskArbitration
pyobjc-framework-CoreFoundation
binwalk
EOF

cat <<EOF > $PROJECT/setup.py
from setuptools import setup, find_packages

setup(
    name="mac_efi_bootkit",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        "pyfatfs",
        "pyobjc-framework-DiskArbitration",
        "pyobjc-framework-CoreFoundation",
        "binwalk"
    ],
    entry_points={
        'console_scripts': [
            'bootkit-build=bootkit.builder:main',
            'bootkit-inject=bootkit.injector:main'
        ]
    }
)
EOF

echo "*.pyc" > $PROJECT/.gitignore
echo "[+] Bootkit scaffold created at: $PROJECT/"
