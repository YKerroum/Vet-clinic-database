CREATE TABLE patients(
    id INT PRIMARY KEY GENERATED ALWAYS as IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories(
    id INT PRIMARY KEY GENERATED ALWAYS as IDENTITY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(100)
);

create index idx_medical_histories_patient_id on medical_histories(patient_id);

CREATE TABLE treatments(
    id INT PRIMARY KEY GENERATED ALWAYS as IDENTITY,
    type VARCHAR(100),
    name VARCHAR(100)
);

CREATE TABLE invoice_items(
    id INT PRIMARY KEY GENERATED ALWAYS as IDENTITY,
    unit_price DECIMAL(8, 2) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(8, 2) NOT NULL,
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
);

create index idx_invoice_items_invoice_id on invoice_items(invoice_id);
create index idx_invoice_items_treatment_id on invoice_items(treatment_id);

CREATE TABLE invoices(
    id INT PRIMARY KEY GENERATED ALWAYS as IDENTITY,
    total_amount DECIMAL(8, 2) NOT NULL,
    generated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    payed_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    medical_history_id INT REFERENCES medical_histories(id) UNIQUE NOT NULL
);

create index idx_invoices_medical_history_id on invoices(medical_history_id);

CREATE TABLE treatment_medical_histories(
    medical_history_id INT REFERENCES medical_histories(id) NOT NULL,
    treatment_id INT REFERENCES treatments(id) NOT NULL,
    id INT PRIMARY KEY GENERATED ALWAYS as IDENTITY
);

create index idx_treatment_medical_histories_medical_history_id on treatment_medical_histories(medical_history_id);
create index idx_treatment_medical_histories_treatment_id on treatment_medical_histories(treatment_id);