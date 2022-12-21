clear 

use choices_dce2


mixlogit choice, ///
	group(group) /// each individual choice is identified by decision_id
	id(id) /// each person is identified by id
	rand(herd good bad self comm)
	
mixlbeta herd good bad self comm, saving(rand_coeffs_self_comm_dce2.dta) replace
