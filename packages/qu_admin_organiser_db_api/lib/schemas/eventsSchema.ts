import { relations } from "drizzle-orm";
import { mysqlTable, varchar } from "drizzle-orm/mysql-core";
import { ticketsSchema } from "./index.js";

const eventsTable = mysqlTable('events', {
    id: varchar('id', { length: 80 }).primaryKey(),
    name: varchar('name', { length: 10 }).notNull(),
    userId: varchar('user_id', { length: 80 }).notNull(),
    userEmail: varchar('user_email', { length: 50 }).notNull(),
    userUsername: varchar('user_username', { length: 10 }).notNull()
});

const eventsRelation = relations(eventsTable, ({ many }) => {
    return {
        tickets: many(ticketsSchema.ticketsTable)
    }
});

export {
    eventsTable,
    eventsRelation
};