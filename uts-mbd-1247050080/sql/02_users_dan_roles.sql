CREATE USER backend_dev WITH PASSWORD 'backend_ifunggul';
CREATE USER bi_dev WITH PASSWORD 'bi_ifunggul';
CREATE USER data_engineer WITH PASSWORD 'de_ifunggul';

GRANT CONNECT ON DATABASE postgres TO backend_dev, bi_dev, data_engineer;
GRANT USAGE ON SCHEMA SALAM TO backend_dev, bi_dev;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;
GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;
GRANT ALL PRIVILEGES ON SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;

ALTER SCHEMA SALAM OWNER TO data_engineer;
ALTER TABLE SALAM.mahasiswas OWNER TO data_engineer;
ALTER VIEW SALAM.vw_rekap_akademik OWNER TO data_engineer;
