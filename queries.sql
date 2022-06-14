-- Lista de pacientes

SELECT subject_id FROM mimiciii.patients ORDER BY subject_id ASC;
-- GET /patients?select=subject_id&order=subject_id.asc

-- Información del paciente

SELECT * FROM mimiciii.patients WHERE subject_id=10019;
-- GET /patients?subject_id=eq.10019

-- Hospitalizaciones en UCI del paciente

SELECT icustay_id FROM mimiciii.icustays WHERE subject_id=10019 ORDER BY icustay_id ASC;
-- GET /icustays?subject_id=eq.10019&select=icustay_id&order=icustay_id.asc

-- Información de la hospitalización en UCI

SELECT * FROM mimiciii.icustays WHERE icustay_id=228977;
-- GET /icustays?icustay_id=eq.228977

-- Parámetros medidos disponibles en la hospitalización en UCI

SELECT DISTINCT d_itemid,label FROM mimiciii.chartevents_d_items WHERE icustay_id=228977 AND valuenum IS NOT NULL ORDER BY label ASC;
-- GET /chartevents_d_items?icustay_id=eq.228977&valuenum=not.is.null&select=d_itemid,label&order=label.asc

-- Mediciones del parámetro en la hospitalización en UCI

SELECT charttime,valuenum FROM mimiciii.chartevents_d_items WHERE icustay_id=228977 AND valuenum IS NOT NULL AND d_itemid = 211;
-- GET /chartevents_d_items?icustay_id=eq.228977&valuenum=not.is.null&select=charttime,valuenum&d_itemid=eq.211