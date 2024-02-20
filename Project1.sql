---1
SELECT * FROM sales_dataset_rfm_prj
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN ordernumber TYPE int USING (ordernumber::integer)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN quantityordered TYPE smallint USING (quantityordered::smallint)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN priceeach TYPE numeric USING (priceeach::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderlinenumber TYPE smallint USING (orderlinenumber::smallint)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN sales TYPE numeric USING (sales::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN priceeach TYPE numeric USING (priceeach::numeric)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderdate TYPE timestamp (2) without time zone 
USING orderdate::timestamp(2) without time zone

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN status TYPE character varying (10) 
USING (status::character varying (10))

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN productline TYPE text USING (productline::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN msrp TYPE smallint USING (msrp::smallint)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN productcode TYPE character USING (productcode::character)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN customername TYPE text USING (customername::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN phone TYPE text USING (phone::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN addressline1 TYPE text USING (addressline1::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN addressline2 TYPE text USING (addressline2::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN city TYPE text USING (city::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN state TYPE text USING (state::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN postalcode TYPE text USING (postalcode::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN country TYPE text USING (country::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN territory TYPE text USING (territory::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN contactfullname TYPE text USING (contactfullname::text)

ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN dealsize TYPE character varying (10) 
USING (dealsize::character varying (10))
