import express, { Router } from "express";
const router = express.Router()
import { signUpController } from "../Controllers/index.js";

router.post('/', signUpController.signUp)

export default router