package gov.in.rgsa.model;

import java.util.HashSet;
import java.util.Set;
import java.util.function.Consumer;
import java.util.stream.Collectors;

public class IecFormModel {

	public static final String SAVE="SAVE", FREEZE="FREEZE", UNFREEZE="UNFREEZE";

	private Integer iecId;
	private Set<Integer> selectedId = new HashSet<>();
	private Integer amount;
	private String remarks=null;
	private Boolean isFreeze=false;
	private String action=SAVE;
	private Boolean isOwnData=true;
	private Boolean isApproved=false;

	public Integer getIecId() {
		return iecId;
	}

	public void setIecId(Integer iecId) {
		this.iecId = iecId;
	}

	public Set<Integer> getSelectedId() {
		return selectedId;
	}

	public void setSelectedId(Set<String> selectedId) {
		this.selectedId.clear();
		this.selectedId = selectedId.stream().map(Integer::parseInt).collect(Collectors.toSet());
	}

	public void setSelectedIdInteger(Set<Integer> selectedId) {
		this.selectedId = selectedId;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

    public Boolean getFreeze() {
        return isFreeze;
    }

    public void setFreeze(Boolean freeze) {
        isFreeze = freeze;
    }

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

    public Boolean getOwnData() {
        return isOwnData;
    }

    public void setOwnData(Boolean ownData) {
        isOwnData = ownData;
    }

    public void setOwnDataCascade(Boolean ownData) {
        isOwnData = ownData;
        if(!isOwnData && isFreeze)
            isFreeze = false;
    }

    public void invokeOnChanges(IecFormModel previous, Consumer<Integer> adder, Consumer<Integer> deleter){
		Set<Integer> added = new HashSet<>(this.selectedId);
		Set<Integer> deleted = new HashSet<>(previous.getSelectedId());
		added.removeAll(previous.getSelectedId());
		deleted.removeAll(this.selectedId);
		for(Integer addition: added){
			adder.accept(addition);
		}
		for(Integer deletion: deleted){
			deleter.accept(deletion);
		}
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}
}
