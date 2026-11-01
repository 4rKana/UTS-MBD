CREATE SCHEMA IF NOT EXISTS SALAM;

CREATE TABLE SALAM.mahasiswas (
    nim CHAR(10) CONSTRAINT pk_mahasiswas PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL CONSTRAINT uq_mahasiswas_email UNIQUE,
    semester INT NOT NULL CONSTRAINT chk_mahasiswas_semester CHECK (semester BETWEEN 1 AND 14),
    ipk NUMERIC(3, 2) DEFAULT 0.00 CONSTRAINT chk_mahasiswas_ipk CHECK (ipk >= 0.00 AND ipk <= 4.00),
    status_akademik VARCHAR(15) DEFAULT 'AKTIF' CONSTRAINT chk_mahasiswas_status CHECK (status_akademik IN ('AKTIF', 'CUTI', 'LULUS', 'DO')),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION SALAM.fn_set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_mahasiswas
BEFORE UPDATE ON SALAM.mahasiswas
FOR EACH ROW
EXECUTE FUNCTION SALAM.fn_set_updated_at();

CREATE OR REPLACE VIEW SALAM.vw_rekap_akademik AS
SELECT semester, status_akademik, COUNT(nim) AS jumlah_mahasiswa, ROUND(AVG(ipk), 2) AS rata_rata_ipk
FROM SALAM.mahasiswas GROUP BY semester, status_akademik;

BEGIN;
INSERT INTO SALAM.mahasiswas (nim, nama_lengkap, email, semester, ipk, status_akademik) VALUES 
('1247050080', 'Arya Fabio Ismail', 'arya.fabio@uinsgd.ac.id', 5, 3.88, 'AKTIF'),
('1247050001', 'Aulia', 'aulia@uinsgd.ac.id', 5, 3.75, 'AKTIF'),
('1247050002', 'Faiz M', 'faiz.m@uinsgd.ac.id', 5, 3.70, 'AKTIF');
COMMIT;
