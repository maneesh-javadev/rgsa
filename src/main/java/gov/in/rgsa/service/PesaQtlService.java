package gov.in.rgsa.service;

import gov.in.rgsa.inbound.QprQuartReply;

import java.util.Map;

public interface PesaQtlService{
    Map<String, Object> getPesaFormMap(Integer quarterId);
    void save(QprQuartReply qprQuartReply);
    void freeze(QprQuartReply qprQuartReply);
    void unFreeze(QprQuartReply qprQuartReply);
}
