-- Loop to create 20 tables and insert 20,000 rows into each
DO $$
DECLARE
    table_num INTEGER;
    i INTEGER;
    table_name TEXT;
BEGIN
    FOR table_num IN 1..20 LOOP
        -- Create table name
        table_name := 'table' || table_num;

        -- Create table
        EXECUTE 'CREATE TABLE ' || table_name || ' (
            id SERIAL PRIMARY KEY,
            column1 VARCHAR(50),
            column2 INTEGER,
            column3 DATE
        )';

        -- Insert 20,000 rows into the table
        FOR i IN 1..20000 LOOP
            EXECUTE 'INSERT INTO ' || table_name || ' (column1, column2, column3)
            VALUES ($1, $2, $3)'
            USING 'SampleText' || i, i, CURRENT_DATE + (i || ' days')::interval;
        END LOOP;
    END LOOP;
END $$;