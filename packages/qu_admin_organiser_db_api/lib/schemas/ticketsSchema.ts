import { relations } from "drizzle-orm";
import { mysqlTable, varchar, datetime, float } from "drizzle-orm/mysql-core";
import { eventsSchema } from "./index.js";

const ticketsTable = mysqlTable('tickets', {
    id: varchar('id', { length: 80 }).primaryKey(),
    price: float('price'),
    eventId: varchar('event_id', { length: 80 }).notNull(),
    userId: varchar('user_id', { length: 80 }).notNull(),
    userEmail: varchar('user_email', { length: 50 }).notNull(),
    userUsername: varchar('user_username', { length: 10 }).notNull(),
    createdAt: datetime('created_at').notNull()
});

const ticketsRelation = relations(ticketsTable, ({ one }) => {
    return {
        event: one(eventsSchema.eventsTable, {
            fields: [ticketsTable.eventId],
            references: [eventsSchema.eventsTable.id]
        })
    }
});

export {
    ticketsTable,
    ticketsRelation
};