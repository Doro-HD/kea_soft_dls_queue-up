import { drizzle } from "drizzle-orm/mysql2";
import { eventsSchema, ticketsSchema, postsSchema } from './schemas/index.js';
import mysql from "mysql2/promise";

const DATABASE_URL = process.env.DATABASE_URL ?? 'No Database Url';

async function connect() {
    const conn = await mysql.createConnection({
        uri: DATABASE_URL
    });

    return drizzle({ client: conn, schema: { ...eventsSchema, ...ticketsSchema, ...postsSchema }, mode: 'default'})
}

function getDB() {
    if (!db) {
        db = connect();
    }

    return db;
}

let db: null | ReturnType<typeof connect> = null;

export {
    getDB
};