import { PrismaClient } from "@prisma/client";
import { compareSync } from "bcrypt";
import * as jwt from 'jsonwebtoken'
import 'dotenv/config'

const prisma = new PrismaClient

export default {
    async login (req, res) {
        try {
            const {email, password} = req.body
            
            const existingUser = await prisma.User.findUnique({
                where: { email }
            })
          if(!existingUser){
              res.status(404).json({message: "User not-found" })
          } 
          
          if (!compareSync(password, user.password)) {
             return res.json({message: "incorrect password try again"})
          } 

          const token = jwt.sign({
            userId: User.id
          }, process.env.JWT_SECRET)

         res.json({User, token})

        } catch (error) {
            console.error(error)
            res.status(500).json({message: " an error occurred during login"})
        }
    }
}