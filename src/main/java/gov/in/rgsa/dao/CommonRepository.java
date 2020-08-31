package gov.in.rgsa.dao;

import java.util.List;
import java.util.Map;

import gov.in.rgsa.entity.FinYear;

/**
 *
 * @author ANJIT
 */

public interface CommonRepository {

	public <T> void save(T entity);

	public <T> T update(T entity);

	public <T> void delete(Class<T> entity, Object id);

	public <T> List<T> findAll(String nameQuery, Map<String, Object> params);

	public <T> T find(String nameQuery, Map<String, Object> params);

	public <T> T find(Class<T> entity, Object id);

	public <T> int excuteUpdate(String query, Map<String, Object> params);

	public <T> List<T> findAllByNativeQuery(String nativeQuery, Map<String, Object> params);
	
	public <T> List<T> findAll(Class<T> resultClass);
	
	public <T> T find(Class<T> resultClass, Map<String, Object> params);

	<T> List<T> findAllByCondition(Class<T> resultClass, Map<String, Object> params);
	
	<T> T findByNativeQuery(String nativeQuery, Map<String, Object> params);
	<T> int excuteUpdateNativeQuery(String query, Map<String, Object> params);
	 List<FinYear> fetchTwoFinYear(String string,Map<String, Object> params);

}
