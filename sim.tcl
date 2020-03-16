create_project -quiet vivado_project ./vivado_project -part xc7z020clg484-1
add_files -norecurse {./source/aes_encryptor.vhd ./source/addroundkey.vhd ./source/common_last_round.vhd ./source/kexp128.vhd ./source/kexp256.vhd ./source/shift_rows.vhd ./source/util_package.vhd ./source/common_round.vhd ./source/kexp192.vhd ./source/mixclumn.vhd ./source/subbytes.vhd}
update_compile_order -fileset sources_1
set_property SOURCE_SET sources_1 [get_filesets sim_1]
set_property -name {xsim.simulate.runtime} -value {60us} -objects [get_filesets sim_1]
add_files -fileset sim_1 -norecurse {./testbench/aes_tb.vhd ./testbench/input.txt}
update_compile_order -fileset sim_1
launch_simulation
close_sim
exit