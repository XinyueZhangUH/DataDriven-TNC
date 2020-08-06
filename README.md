# DataDriven-TNC
### Prerequisites: 
MATLAB, Gurobi ([Set up Gurobi for MATLAB intructions](https://www.gurobi.com/documentation/9.0/quickstart_mac/matlab_setting_up_grb_for_.html))
### Usage:
There are two main files for two cities `mainC.m` and `mainX.m`. Just simply run the two main files and they will output all the figures. If the iteration is set as 50, it may take a long time to run the code. Therefore, in this code, the iteration is set as 5. It is easy to change line 3 of `mainC.m` and `mainX.m` for the number of iterations.

The precalculated results are stored in the `result` folder. Run `plotResult.m` to check the same figures as in the paper.
