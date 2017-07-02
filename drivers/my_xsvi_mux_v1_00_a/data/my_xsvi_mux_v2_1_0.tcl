##############################################################################
## Filename:          C:\Users\mt171850\Documents\Pour_etudiant_TP_video\IVK_EDK_Demo\IVK_Repository\MyProcessorIPLib/drivers/my_xsvi_mux_v1_00_a/data/my_xsvi_mux_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Tue Nov 15 17:42:12 2016 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "my_xsvi_mux" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
