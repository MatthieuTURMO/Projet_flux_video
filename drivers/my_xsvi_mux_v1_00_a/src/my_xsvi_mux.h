/*****************************************************************************
* Filename:          C:\Users\mt171850\Documents\Pour_etudiant_TP_video\IVK_EDK_Demo\IVK_Repository\MyProcessorIPLib/drivers/my_xsvi_mux_v1_00_a/src/my_xsvi_mux.h
* Version:           1.00.a
* Description:       my_xsvi_mux Driver Header File
* Date:              Tue Nov 15 17:42:12 2016 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef MY_XSVI_MUX_H
#define MY_XSVI_MUX_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 */
#define MY_XSVI_MUX_USER_SLV_SPACE_OFFSET (0x00000000)
#define MY_XSVI_MUX_SLV_REG0_OFFSET (MY_XSVI_MUX_USER_SLV_SPACE_OFFSET + 0x00000000)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a MY_XSVI_MUX register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the MY_XSVI_MUX device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void MY_XSVI_MUX_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define MY_XSVI_MUX_mWriteReg(BaseAddress, RegOffset, Data) \
 	xil_io_out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a MY_XSVI_MUX register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the MY_XSVI_MUX device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 MY_XSVI_MUX_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define MY_XSVI_MUX_mReadReg(BaseAddress, RegOffset) \
 	xil_io_in32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from MY_XSVI_MUX user logic slave registers.
 *
 * @param   BaseAddress is the base address of the MY_XSVI_MUX device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void MY_XSVI_MUX_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 MY_XSVI_MUX_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define MY_XSVI_MUX_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	xil_io_out32((BaseAddress) + (MY_XSVI_MUX_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))

#define MY_XSVI_MUX_mReadSlaveReg0(BaseAddress, RegOffset) \
 	xil_io_in32((BaseAddress) + (MY_XSVI_MUX_SLV_REG0_OFFSET) + (RegOffset))

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the MY_XSVI_MUX instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus MY_XSVI_MUX_SelfTest(void * baseaddr_p);

#endif /** MY_XSVI_MUX_H */
