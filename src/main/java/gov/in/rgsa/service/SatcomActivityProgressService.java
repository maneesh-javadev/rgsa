package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.QuarterDuration;
import gov.in.rgsa.entity.SatcomActivityProgress;
import gov.in.rgsa.entity.SatcomLevel;
import gov.in.rgsa.entity.SatcomMaster;

public interface SatcomActivityProgressService {
	
public void savesatcomProgress(SatcomActivityProgress satcomActivityProgress);
	
public List<SatcomActivityProgress> fetchSatcomProgress();

public SatcomActivityProgress getSatcomProgress(int satcomActivityId, int quarterId);

public SatcomActivityProgress getSatcomProgressReportToGeReportId(int satcomActivityId);
}
