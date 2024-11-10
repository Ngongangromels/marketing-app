import prismaClient from '@prisma/client'
const { PrismaClient } = prismaClient
const prisma = new PrismaClient()
const { user: User } = prisma

export default {
    getAll(req, res) {
        user.findMany()
            .then((data) => {
                res.status(200).send(data)
            })
            .catch((err) => {
                res.status(500).send({
                    message: error.message,
                })
            })
    },
}
