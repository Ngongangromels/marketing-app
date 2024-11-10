import express from "express";
const router = express.Router()

import { loginController } from "../Controllers/index.js";

router.post('/', loginController)

export default router