package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.TrgDetailsOfHundredDaysProgram;
import gov.in.rgsa.entity.TrgOfHundredDaysProgram;
import gov.in.rgsa.entity.TrgOfHundredDaysProgramCh1;

public interface HundredDayTrainingDetailsService {

	void saveDeatils(TrgOfHundredDaysProgramCh1 entity);

	TrgOfHundredDaysProgramCh1 fetchTrgOfHundredDaysProgram();

	List<TrgDetailsOfHundredDaysProgram> fetchTrgDetailByTrgId(Long trgOfHundredDaysProgramId);

}
