package gov.in.rgsa.daoImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import gov.in.rgsa.dao.CommonRepository;
/**
*
* @author ANJIT
*/

@Repository
@Transactional
public class CommonRepositoryImpl implements CommonRepository {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public <T> void save(T entity) {

		entityManager.persist(entity);
	}

	@Override
	public <T> T update(T enity) {

		return entityManager.merge(enity);
	}

	@Override
	public <T> void delete(Class<T> entity, Object id) {

		entityManager.remove(this.find(entity, id));
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> List<T> findAll(String nameQuery, Map<String, Object> params) {

		Query query = entityManager.createNamedQuery(nameQuery);
		if (MapUtils.isNotEmpty(params)) {
			for (Entry<String, Object> param : params.entrySet()) {
				query.setParameter(param.getKey(), param.getValue());
			}
		}
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> T find(String nameQuery, Map<String, Object> params) {
		Query query = entityManager.createNamedQuery(nameQuery);
		if (MapUtils.isNotEmpty(params)) {
			for (Entry<String, Object> param : params.entrySet()) {
				query.setParameter(param.getKey(), param.getValue());
			}
		}
		return (T) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> T find(Class<T> entity, Object id) {

		return (T) entityManager.find(entity, id);
	}

	@Override
	public <T> int excuteUpdate(String query, Map<String, Object> params) {

		Query query1 = entityManager.createNamedQuery(query);
		if (MapUtils.isNotEmpty(params)) {
			for (Entry<String, Object> param : params.entrySet()) {
				query1.setParameter(param.getKey(), param.getValue());
			}
		}
		return query1.executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public <T> List<T> findAllByNativeQuery(String nativeQuery, Map<String, Object> params) {
		
		Query query = entityManager.createNativeQuery(nativeQuery);
		if (MapUtils.isNotEmpty(params)) {
			for (Entry<String, Object> param : params.entrySet()) {
				query.setParameter(param.getKey(), param.getValue());
			}
		}
		return  query.getResultList();
	}

	@Override
	public <T> List<T> findAll(Class<T> resultClass) {
		CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<T> cq = cb.createQuery(resultClass);
        Root<T> rootEntry = cq.from(resultClass);
        CriteriaQuery<T> all = cq.select(rootEntry);
        TypedQuery<T> allQuery = entityManager.createQuery(all);
        return allQuery.getResultList();
	}

	@Override
	public <T> T find(Class<T> resultClass, Map<String, Object> params) {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<T> query = criteriaBuilder.createQuery(resultClass);
        Root<T> rootEntry = query.from(resultClass);
        List<Predicate> predicates = new ArrayList<>();
        params.forEach((k, v) -> {
        	predicates.add( criteriaBuilder.equal(rootEntry.get(k), v) );        	
        });
        query.where(predicates.toArray(new Predicate[predicates.size()]));
        try {
        	return entityManager.createQuery(query).getSingleResult();
        }catch(NoResultException ex) {
        	return null;
        }
	}

	

}
