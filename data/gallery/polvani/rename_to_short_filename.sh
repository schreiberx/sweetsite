#! /bin/bash

for i in *.png; do
	NAME="$i"
	NAME="${NAME/bpolvani_g9.81_h10000_f7.2921e-05_p0_a6371220_u2e-05_U8_rob1_fsph0_tsm_ln_erk_tso4_tsob1_C000.0025_/}"
	NAME="${NAME/_M0200_MPI_space01_time001_output_diag_vort_t00000001000.00000000/}"
	
	#mv "$i" "$NAME"

	# trim
	convert "$i" -trim "$NAME"
done

