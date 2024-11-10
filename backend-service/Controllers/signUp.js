import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt"

const prisma = new PrismaClient()

export default {
    async signUp (req, res){
        try {
            const { email, name, password } = req.body
            const solde = req.body.solde || 0.0

            if (!email || !name || !password) {
                return res.status(400).json({ message: "Missing required fields: email, name, or password." })
            }

            const existingUser = await prisma.User.findFirst({
                where: { email }
            })

            if (existingUser) {
                return res.status(400).json({message: "Email already in use."})
            }

            const hashedPassword = bcrypt.hashSync(password, 10);

            const newUser = await prisma.User.create({
                data:{
                    email,
                    name,
                    password: hashedPassword,
                    solde: solde,
                }
            })
            res.status(401).json({message: "User created successfully.", user: newUser})

        } catch (error) {
            console.error(error)
            res.status(500).json({message: " an error occurred during sign-Up"})
        }
    }
}