##############################################################################
## Filename:          C:\Users\mt171850\Documents\Pour_etudiant_TP_video\IVK_EDK_Demo\IVK_Repository\MyProcessorIPLib/drivers/grayl_v1_00_a/data/grayl_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Mon Nov 28 15:11:13 2016 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "grayl" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
