-- Lista de pacientes

SELECT subject_id FROM mimiciii.patients;
-- GET /patients?select=subject_id

-- Información del paciente

SELECT * FROM mimiciii.patients WHERE subject_id=10019;
-- GET /patients?subject_id=eq.10019

-- Hospitalizaciones en UCI del paciente

SELECT icustay_id FROM mimiciii.icustays WHERE subject_id=10019;
-- GET /icustays?subject_id=eq.10019&select=icustay_id

-- Información de la hospitalización en UCI

SELECT * FROM mimiciii.icustays WHERE icustay_id=228977;
-- GET /icustays?icustay_id=eq.228977

-- Parámetros medidos disponibles en la hospitalización en UCI

SELECT DISTINCT d_itemid,label FROM mimiciii.chartevents_d_items WHERE icustay_id=228977 AND valuenum IS NOT NULL;
-- GET /chartevents_d_items?icustay_id=eq.228977&valuenum=not.is.null&select=d_itemid,label

-- Mediciones del parámetro en la hospitalización en UCI

SELECT charttime,valuenum FROM mimiciii.chartevents_d_items WHERE icustay_id=228977 AND valuenum IS NOT NULL AND d_itemid = 211;
-- GET /chartevents_d_items?icustay_id=eq.228977&valuenum=not.is.null&select=charttime,valuenum&d_itemid=eq.211