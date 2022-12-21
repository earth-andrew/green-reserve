clear 

use choices_dce2


mixlogit choice, ///
	group(group) /// each individual choice is identified by decision_id
	id(id) /// each person is identified by id
	rand(herd good bad self comm)
	
mixlbeta herd good bad self comm, saving(rand_coeffs_self_comm_dce2.dta) replace

estimates clear

gen alltime = self + comm

mixlogit choice, ///
	group(group) /// each individual choice is identified by decision_id
	id(id) /// each person is identified by id
	rand(herd good bad alltime)
	
mixlbeta herd good bad alltime, saving(rand_coeffs_pooled_time_dce2.dta) replace

clear

use choices_dce1


mixlogit choice, ///
	group(group) /// each individual choice is identified by decision_id
	id(id) /// each person is identified by id
	rand(herd good bad self comm)
	
mixlbeta herd good bad self comm, saving(rand_coeffs_self_comm_dce1.dta) replace

estimates clear

gen alltime = self + comm

mixlogit choice, ///
	group(group) /// each individual choice is identified by decision_id
	id(id) /// each person is identified by id
	rand(herd good bad alltime)
	
mixlbeta herd good bad alltime, saving(rand_coeffs_pooled_time_dce1.dta) replace
