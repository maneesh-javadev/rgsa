package gov.in.rgsa.service;

import gov.in.rgsa.entity.TrgDetailsOfHundredDaysProgram;

public interface HundredDayTrainingDetailsService {

	void saveDeatils(TrgDetailsOfHundredDaysProgram entity);

	TrgDetailsOfHundredDaysProgram fetchDetails();

}
