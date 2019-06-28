package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.TrgDetailsOfHundredDaysProgram;
import gov.in.rgsa.entity.TrgOfHundredDaysProgramCh1;
import gov.in.rgsa.entity.TrgOfHundredDaysProgramCh2;

public interface HundredDayTrainingDetailsService {

	void saveDeatils(TrgOfHundredDaysProgramCh2 entity);

	TrgOfHundredDaysProgramCh1 fetchTrgOfHundredDaysProgram();

	List<TrgDetailsOfHundredDaysProgram> fetchTrgDetailByTrgId(Long trgOfHundredDaysProgramId);

	TrgOfHundredDaysProgramCh2 fetchTrgOfHundredDaysProgramByDate(TrgOfHundredDaysProgramCh2 entity);

	TrgOfHundredDaysProgramCh2 fetchLatestData();

}
