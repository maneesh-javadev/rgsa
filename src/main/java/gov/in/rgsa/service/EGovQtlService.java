package gov.in.rgsa.service;

import gov.in.rgsa.inbound.QprEGovReq;

import java.util.Map;

public interface EGovQtlService {
    Map<String, Object> getEGovFormMap(Integer quarterId);
    void save(QprEGovReq qprEGovReq);
    void unFreeze(QprEGovReq qprEGovReq);
    void freeze(QprEGovReq qprEGovReq);
}
