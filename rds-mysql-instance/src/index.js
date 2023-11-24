const fs = require("fs");
const path = require("path");
const mysql = require("mysql");
const {
  SecretsManagerClient,
  GetSecretValueCommand,
} = require("@aws-sdk/client-secrets-manager");

const SECRET_ARN = process.env.SECRET_ARN;
const AWS_REGION = process.env.AWS_REGION;
const DB_HOST = process.env.DB_HOST;
const client = new SecretsManagerClient({ region: AWS_REGION });

exports.handler = async () => {
  try {
    console.log(`get secret arn from env variable: ${SECRET_ARN}`);
    console.log(`get database host from env variable: ${DB_HOST}`);
    const command = new GetSecretValueCommand({
      SecretId: SECRET_ARN,
    });
    const response = await client.send(command);
    const { username, password } = JSON.parse(response.SecretString);
    console.log("get db secret from secret manager");

    const connection = mysql.createConnection({
      host: DB_HOST,
      user: username,
      password,
      multipleStatements: true,
    });

    connection.connect();

    const sqlScript = fs
      .readFileSync(path.join(__dirname, "script.sql"))
      .toString();
    const res = await query(connection, sqlScript);
    console.log(`query result: ${JSON.stringify(res)}`);
    return {
      status: "OK",
      results: res,
    };
  } catch (err) {
    return {
      status: "ERROR",
      err,
      message: err.message,
    };
  }
};

function query(connection, sql) {
  return new Promise((resolve, reject) => {
    connection.query(sql, (error, res) => {
      if (error) return reject(error);

      return resolve(res);
    });
  });
}
