import { relations } from "drizzle-orm";
import { datetime, mysqlTable, varchar } from "drizzle-orm/mysql-core";
import { commentsSchema } from "./index.js";

const postsTable = mysqlTable('posts', {
    id: varchar('id', { length: 80 }).primaryKey(),
    title: varchar('title', { length: 10 }).notNull(),
    text: varchar('text', { length: 10 }).notNull(),
    userId: varchar('user_id', { length: 80 }).notNull(),
    userUsername: varchar('user_username', { length: 10 }).notNull(),
    createdAt: datetime('created_at').notNull()
});

const postsRelation = relations(postsTable, ({ many }) => {
    return {
        comments: many(commentsSchema.commentsTable)
    }
});

export {
    postsTable,
    postsRelation
};