package gov.in.rgsa.config;

import org.hibernate.dialect.PostgreSQL95Dialect;
import java.sql.Types;

public class ExtendedPS95Dialect extends PostgreSQL95Dialect {
	public ExtendedPS95Dialect() {
        super();
        this.registerColumnType( Types.JAVA_OBJECT, "jsonb" );
    }
}
