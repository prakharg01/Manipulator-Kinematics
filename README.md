# Kinematics-3DOF-Robotic-Arm-Matlab

This repository provides an implementation of Forward Kinematics (FK) and Inverse Kinematics (IK) for a 3DOF spatial manipulator using both numerical and analytical methods. The kinematics are implemented in both VREP (CoppeliaSim) and MATLAB.

![Untitled Project](https://user-images.githubusercontent.com/61418939/113280137-917beb80-9301-11eb-84f0-7f5ee6c0c84a.gif)

## Overview
The purpose of this project is to calculate the FK and IK for a 3DOF robotic arm. The following MATLAB scripts are included:

- `FK3DOF`: Calculates the forward kinematics for a 3DOF planar arm.
- `FK3DOFElbow`: Calculates the forward kinematics for a 3DOF (3D) arm.
- `IK3DOF`: Calculates the inverse kinematics for a 3DOF planar arm.
- `IK3DOFElbow`: Calculates the inverse kinematics for a 3DOF (3D) arm.
- `IK3DOFPATHFOLLOWING`: Calculates the inverse kinematics for a 3DOF planar arm using the numerical Newton-Raphson method and the inverse pseudo Jacobian.
- `DH.M`: A function to compute the Denavit-Hartenberg (DH) parameters.

The intermediate steps of the Newton-Raphson algorithm can be visualized in VREP (CoppeliaSim) using the provided scene file `3rikv2.0.ttt`.

## Usage
To use the implementation, follow these steps:
1. Run the `IK3DOFPATHFOLLOWING.m` script, which will generate `path.csv` and `data.csv`.
2. Load the `path.csv` file in VREP (CoppeliaSim).
3. Simulate the scene using the `3rikv2.0.ttt` file.

Make sure to have VREP (CoppeliaSim) installed and properly configured for the simulation.

## Repository Contents
The repository contains the following files:

- `FK3DOF.m`: MATLAB script for the forward kinematics of a 3DOF planar arm.
- `FK3DOFElbow.m`: MATLAB script for the forward kinematics of a 3DOF (3D) arm.
- `IK3DOF.m`: MATLAB script for the inverse kinematics of a 3DOF planar arm.
- `IK3DOFElbow.m`: MATLAB script for the inverse kinematics of a 3DOF (3D) arm.
- `IK3DOFPATHFOLLOWING.m`: MATLAB script for the inverse kinematics of a 3DOF planar arm using the numerical Newton-Raphson method and the inverse pseudo Jacobian.
- `DH.m`: MATLAB function to compute the DH parameters.
- `3rikv2.0.ttt`: VREP (CoppeliaSim) scene file for visualizing the intermediate steps of the Newton-Raphson algorithm.

## License
The code in this repository is licensed under the [MIT License](LICENSE).

## Acknowledgements
The implementation of the Forward and Inverse Kinematics for the 3DOF robotic arm in MATLAB and VREP (CoppeliaSim) was developed by [Prakhar Goel]. If you have any questions or suggestions, feel free to reach out.

[Prakhar Goel]: [https://www.linkedin.com/in/prakhar-goel-4616501a5/]
