package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;

@Entity
@Table(name="upload_document_type", schema="rgsa")
@NamedNativeQueries({@NamedNativeQuery(query = "SELECT * FROM rgsa.upload_document_type  ORDER BY name", name = "DOCUMENT_TYPE_LIST", resultClass = UploadDocumentType.class)})
public class UploadDocumentType implements Serializable{
	
	@Id
	@Column(name="type_id")
	private Integer typeId;
	
	@Column(name="name")
	private String name;

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
