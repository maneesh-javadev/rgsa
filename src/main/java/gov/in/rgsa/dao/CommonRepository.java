package gov.in.rgsa.dao;

import java.util.List;
import java.util.Map;

/**
 *
 * @author ANJIT
 */

public interface CommonRepository {

	public <T> void save(T entity);

	public <T> T update(T enity);

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
}
