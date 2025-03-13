import amqplib, { type ChannelModel, type ConsumeMessage } from 'amqplib';

async function connect(url: string) {
    return amqplib.connect(url);
}

async function createPublisher(conn: ChannelModel, queueName: string) {
    const channel = await conn.createChannel();

    return (msg: string) => {
        channel.sendToQueue(queueName, Buffer.from(msg));
    };
}

type ConsumerFn = (msg: ConsumeMessage | null) => void;

async function startConsumer(conn: ChannelModel, queueName: string, consumeFn: ConsumerFn) {
    const channel = await conn.createChannel();
    await channel.assertQueue(queueName);

    channel.consume(queueName, consumeFn);
}


export {
    connect,
    createPublisher,
    startConsumer,
    type ConsumerFn
};