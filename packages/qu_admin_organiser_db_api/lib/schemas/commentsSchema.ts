import { relations } from "drizzle-orm";
import { datetime, mysqlTable, varchar } from "drizzle-orm/mysql-core";
import { postsSchema } from "./index.js";

const commentsTable = mysqlTable('comments', {
    id: varchar('id', { length: 80 }).primaryKey(),
    text: varchar('text', { length: 10 }).notNull(),
    userId: varchar('user_id', { length: 80 }).notNull(),
    userUsername: varchar('user_username', { length: 10 }).notNull(),
    postId: varchar('post_id', { length: 80 }).notNull(),
    createdAt: datetime('created_at').notNull()
});

const commentsRelation = relations(commentsTable, ({ one }) => {
    return {
        comments: one(postsSchema.postsTable, {
            fields: [commentsTable.postId],
            references: [postsSchema.postsTable.id]
        })
    }
});

export {
    commentsTable,
    commentsRelation
}