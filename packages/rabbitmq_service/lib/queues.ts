import type { ChannelModel } from 'amqplib';
import { createPublisher, startConsumer, type ConsumerFn } from './service.js';

/**
 * @description
 * A helper object for publishing and consuming from the correct queues
 */
type Queue = {
    createPublisher: (conn: ChannelModel) => ReturnType<typeof createPublisher>;
    startConsumer: (
        conn: ChannelModel,
        consumerFn: ConsumerFn
    ) => ReturnType<typeof startConsumer>;
};

function createQueue(queueName: string): Queue {
    return {
        createPublisher: (conn: ChannelModel) =>
            createPublisher(conn, queueName),
        startConsumer: (conn: ChannelModel, consumerFn: ConsumerFn) =>
            startConsumer(conn, queueName, consumerFn),
    };
}

/**
 * @description
 * A helper object for publishing and consuming from the 'create-organiser' queue
 */
const createOrganiserQueue = createQueue('create-organiser');

/**
 * @description
 * A helper object for publishing and consuming from the 'create-event' queue
 */
const createEventQueue = createQueue('create-event');

/**
 * @description
 * A helper object for publishing and consuming from the 'create-post' queue
 */
const createPostQueue = createQueue('create-post');

/**
 * @description
 * A helper object for publishing and consuming from the 'create-comment' queue
 */
const createCommentQueue = createQueue('create-comment');

/**
 * @description
 * A helper object for publishing and consuming from the 'create-guest' queue
 */
const createGuestQueue = createQueue('create-guest');

/**
 * @description
 * A helper object for publishing and consuming from the 'create-ticket' queue
 */
const createTicketQueue = createQueue('create-ticket');

export {
    createOrganiserQueue,
    createEventQueue,
    createPostQueue,
    createCommentQueue,
    createGuestQueue,
    createTicketQueue,
};
