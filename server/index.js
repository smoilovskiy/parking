const express = require("express");
const mysql = require("mysql2/promise");
var cors = require('cors');

let db = null;
const app = express();

app.use(cors());
app.use(express.json());

app.post('/create-vehicle', async (req, res, next) => {
  const make = req.body.make;
  const model = req.body.model;
  const licensePlate = req.body.licensePlate;

  await db.query("INSERT INTO vehicles (make, model, licensePlate) VALUES (?,?,?);", [make, model, licensePlate]);

  console.log('Post Ok')
  res.json({ status: "OK" });
  next();
});


app.get('/vehicles', async (req, res, next) => {

  const [rows] = await db.query("SELECT * FROM vehicles;");
  console.log('Get Ok')
  res.json(rows);
  next();
});

async function main() {
  db = await mysql.createConnection({
    host: "us-cdbr-east-04.cleardb.com",
    user: "b4f98c27ecf28a",
    password: "bb834730",
    database: "heroku_8cc538b8064e82b",
    timezone: "+00:00",
    charset: "utf8mb4_general_ci",
  });

  app.listen(5000);
}

main();