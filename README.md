# aws-serverless-postgres

### This Example
* Choses AWS Aurora Serverless for cloud-cost reasons. Choosing a classic Postgres DB via AWS's RDS is another option. 
* how to create a Postgres Database in AWS using Aurora Serverless
* how to fuly automatically conect to the database

### not covered by this example
* This example exposes to the DB to the public internet. In an enterprise setting, it would be connected an internal company network. 
* This example uses a single account to access the DB. In an enterprise setting, one would probably use accounts tied to real users. This can probably be accounts in postgres, AWS IAM, or OICD (workload identities).
