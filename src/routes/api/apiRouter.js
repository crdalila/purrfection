import { Router } from "express";
import catRouter from "./catApiRouter.js";
import userRouter from "./userAPIRouter.js";
import appointmentRouter from "./appointmentAPIRouter.js";
import authRouter from "./authAPIRouter.js";

const router = Router();

router.use("/cat",catRouter);
router.use("/user",userRouter);
router.use("/appointments",appointmentRouter);
// router.use("/",authRouter); TODO descomentar

export default router