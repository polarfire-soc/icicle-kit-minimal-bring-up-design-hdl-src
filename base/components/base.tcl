# Creating SmartDesign base
set sd_name {base}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {MMUART_0_RXD_F2M} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MMUART_1_RXD_F2M} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REFCLK_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {REFCLK} -port_direction {IN} -port_is_pad {1}

sd_create_scalar_port -sd_name ${sd_name} -port_name {CKE} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CS} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MMUART_0_TXD_M2F} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MMUART_1_TXD_M2F} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ODT} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RCOSC_160MHZ_GL} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {OUT} -port_is_pad {1}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {CA} -port_direction {OUT} -port_range {[5:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM} -port_direction {OUT} -port_range {[3:0]} -port_is_pad {1}

sd_create_bus_port -sd_name ${sd_name} -port_name {DQS_N} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS} -port_direction {INOUT} -port_range {[3:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQ} -port_direction {INOUT} -port_range {[31:0]} -port_is_pad {1}

# Add PF_OSC_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_OSC_C0} -instance_name {PF_OSC_C0_0}



# Add test_mss_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {test_mss} -instance_name {test_mss_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {test_mss_0:MSS_RESET_N_F2M} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {test_mss_0:MMUART_0_TXD_OE_M2F}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {test_mss_0:PLL_CPU_LOCK_M2F}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {test_mss_0:MSS_RESET_N_M2F}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK" "test_mss_0:CK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE" "test_mss_0:CKE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK_N" "test_mss_0:CK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS" "test_mss_0:CS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_0_RXD_F2M" "test_mss_0:MMUART_0_RXD_F2M" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_0_TXD_M2F" "test_mss_0:MMUART_0_TXD_M2F" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_1_RXD_F2M" "test_mss_0:MMUART_1_RXD_F2M" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_1_TXD_M2F" "test_mss_0:MMUART_1_TXD_M2F" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ODT" "test_mss_0:ODT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_OSC_C0_0:RCOSC_160MHZ_NGMUX" "RCOSC_160MHZ_GL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REFCLK" "test_mss_0:REFCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"REFCLK_N" "test_mss_0:REFCLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "test_mss_0:RESET_N" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CA" "test_mss_0:CA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DM" "test_mss_0:DM" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQ" "test_mss_0:DQ" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS" "test_mss_0:DQS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS_N" "test_mss_0:DQS_N" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the smartDesign
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign base
generate_component -component_name ${sd_name}
