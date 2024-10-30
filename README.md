# TAG Application Installation Instructions

### Preparation for Application Installation (further modifications will be made in our values.yaml)

#### 1. Before installation, it is necessary to prepare (install separately) PostgreSQL version 14.*
   - Specify the database host at `global.db.secret.data.dbhost`
   - Specify the database port at `global.db.secret.data.dbport`
   - Specify the database user at `global.db.secret.data.dbuser` (the user must have permissions to create databases)
   - Specify the password for the database user `global.db.secret.data.dbpwd`
   - Specify the database name at `global.db.secret.data.dbname` (Note: you don't need to pre-create a database with the specified name, the application will create the database and necessary tables in it automatically)

#### 2. Before installation, it is necessary to prepare (install separately) TimescaleDB (https://docs.timescale.com/) version 16.* 
   - Specify the database host at `global.db.secret.data.dbhoststat`
   - Specify the database port at `global.db.secret.data.dbportstat`
   - Specify the database user at `global.db.secret.data.dbuserstat`
   - Specify the password for the database user `global.db.secret.data.dbpwdstat`
   - Specify the database name at `global.db.secret.data.dbnamestat`

#### 3. Before installation, it is necessary to prepare (install separately) Redis version 7.0.*
   - Specify the host of the Redis database at `global.redis.secret.data.host`
   - Specify the port of the Redis database at `global.redis.secret.data.port`
   - Specify the Redis password for the database user at `global.redis.secret.data.password` (This field can be left empty if Redis does not have a password)

#### 4. Specify the domain in `global.domain` (for example, test.com)

#### 5. Specify the subdomain in `global.subdomain` (for example, tag) - Then we will have tag.test.com

#### 6. Specify your IngressClass in `global.ingress.className` and `global.ingress.annotations.ingress.class`

#### 7. If you are using AWS, it is recommended to create an EFS and include it in `global.tag_license.storage`

#### 8. Request a license from our manager and place it in the chart in the license folder, the file must be named `license.key`.


### Application Installation/Update
`helm upgrade --install -n tag-prod --create-namespace tag .`  

### License Update

`curl -F upload=@license.key https://tag.test.com/internal/license`

where `license.key` - is our license file.