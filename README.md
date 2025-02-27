# Hermitian-Correlations

This repository contains MATLAB code to analyze the dependence of side peaks in Auto-Correlation Functions (ACF) and Cross-Correlation Functions (CCF) on the phase angles of coefficients in a Hermitian matrix. The code generates 3D surface plots and animations to visualize the relationships between the phase angles and the resulting side peaks.

---

## Repository Structure

The repository contains the following files:

- **`A1_and_A2.m`**  
  This script analyzes the dependence of ACF and CCF side peaks on the phase angles of coefficients `a_1` and `a_2`. It generates 3D surface plots for both ACF and CCF.

- **`A1_and_A3.m`**  
  This script analyzes the dependence of ACF and CCF side peaks on the phase angles of coefficients `a_1` and `a_3`. It generates 3D surface plots for both ACF and CCF.

- **`A2_and_A3.m`**  
  This script analyzes the dependence of ACF and CCF side peaks on the phase angles of coefficients `a_2` and `a_3`. It generates 3D surface plots for both ACF and CCF.

- **`Animation.m`**  
  This script creates an animation to visualize how the ACF and CCF side peaks change with respect to an additional variable (e.g., time or another phase angle). The animation provides a dynamic view of the dependencies.

---

## Code Overview

### Key Variables
- `R1`, `R2`, `R3`: Fixed magnitudes of the coefficients.
- `range_a1`, `range_a2`, `range_a3`: Phase angle ranges for the coefficients.
- `result_AKF`, `result_VKF`: Matrices to store the computed side peaks for ACF and CCF, respectively.
- `n`: Order of the Hermitian matrix.
- `combs`: Binomial coefficients for selecting vectors for CCF computation.

### Main Workflow
1. The code iterates over the phase angle ranges for the selected coefficients.
2. For each combination of phase angles, a Hermitian matrix is constructed.
3. Eigenvectors of the matrix are computed.
4. ACF and CCF are calculated using the eigenvectors.
5. The largest side peaks of ACF and CCF are identified and stored.
6. 3D surface plots are generated to visualize the dependence of side peaks on the phase angles.

### Animation
The `Animation.m` script extends the analysis by introducing an additional variable (e.g., time or another phase angle). It creates a sequence of 3D surface plots, which are combined into an animation to show how the side peaks evolve with respect to the additional variable.

## How to Use

1. **Clone the repository**:
   ```bash
   git clone alkotras42/Hermitian-Correlations
   cd Hermitian-Correlations
   ```
2. **Open MATLAB** and navigate to the repository folder.

3. **Run the desired script**:
   - To analyze the dependence on `a_1` and `a_2`, run `A1_and_A2.m`.
   - To analyze the dependence on `a_1` and `a_3`, run `A1_and_A3.m`.
   - To analyze the dependence on `a_2` and `a_3`, run `A2_and_A3.m`.
   - To create an animation, run `Animation.m`.

4. **View the results**:
   - The 3D surface plots will be displayed in MATLAB for `A1_and_A2.m`, `A1_and_A3.m`, and `A2_and_A3.m`.
   - The animation created by `Animation.m` will show how the side peaks change dynamically with respect to an additional variable.

---

## Dependencies

- **MATLAB** (tested on R2022b or later).
- No additional MATLAB toolboxes are required (basic MATLAB functionality is used).

---

## Results

- **3D Surface Plots**: Visualize the relationship between phase angles (`a_1`, `a_2`, `a_3`) and the side peaks of ACF and CCF.
- **Animation**: Demonstrates how the side peaks evolve dynamically with respect to an additional variable (e.g., time or another phase angle).

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## Author

Kirill Stogniy
[GitHub Profile](https://github.com/alkotras42)
