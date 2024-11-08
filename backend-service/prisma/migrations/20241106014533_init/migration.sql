 -- CreateEnum
CREATE TYPE "TypeApi" AS ENUM ('GET', 'POST');

-- CreateEnum
CREATE TYPE "Format" AS ENUM ('JSON', 'RESTFULL');

-- CreateEnum
CREATE TYPE "ModeInvoicing" AS ENUM ('VOLUME', 'CURRENCY');

-- CreateEnum
CREATE TYPE "TypeCampaign" AS ENUM ('SMS', 'SMSENRICHI');

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('FINALCUSTOMER', 'SUPERADMIN', 'RETAILER');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "solde" DOUBLE PRECISION NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'FINALCUSTOMER',
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "invoicingId" INTEGER NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SuperAdmin" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "SuperAdmin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Retailer" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "superAdId" INTEGER NOT NULL,

    CONSTRAINT "Retailer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FinalCustomer" (
    "id" SERIAL NOT NULL,
    "senderId" VARCHAR(11) NOT NULL,
    "userId" INTEGER NOT NULL,
    "retailerId" INTEGER NOT NULL,
    "superAdId" INTEGER NOT NULL,

    CONSTRAINT "FinalCustomer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contact" (
    "id" SERIAL NOT NULL,
    "nameContact" TEXT NOT NULL,
    "numberContact" INTEGER NOT NULL,
    "creatAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Contact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SmsCampaign" (
    "id" SERIAL NOT NULL,
    "nameCampaign" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "typeCampaign" "TypeCampaign" NOT NULL DEFAULT 'SMS',
    "clickRate" INTEGER NOT NULL,
    "sendSms" INTEGER NOT NULL,
    "smsRead" INTEGER NOT NULL,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataCampaign" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,
    "operateurId" INTEGER NOT NULL,
    "invoicingId" INTEGER NOT NULL,

    CONSTRAINT "SmsCampaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Operateur" (
    "id" SERIAL NOT NULL,
    "prefixe" TEXT NOT NULL,
    "operatorName" TEXT NOT NULL,
    "pays" TEXT NOT NULL,
    "creatAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Operateur_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tarif" (
    "userId" INTEGER NOT NULL,
    "operateurId" INTEGER NOT NULL,
    "assigneAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,

    CONSTRAINT "Tarif_pkey" PRIMARY KEY ("userId","operateurId")
);

-- CreateTable
CREATE TABLE "Invoicing" (
    "id" SERIAL NOT NULL,
    "modeI" "ModeInvoicing" NOT NULL DEFAULT 'VOLUME',

    CONSTRAINT "Invoicing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" SERIAL NOT NULL,
    "cost" DOUBLE PRECISION NOT NULL,
    "sentStatus" BOOLEAN NOT NULL,

    CONSTRAINT "Transaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Api" (
    "id" SERIAL NOT NULL,
    "baseUrl" TEXT NOT NULL,
    "typeApi" "TypeApi" NOT NULL DEFAULT 'GET',
    "format" "Format" NOT NULL DEFAULT 'JSON',
    "apiParameter" TEXT[],
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Api_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "SuperAdmin_userId_key" ON "SuperAdmin"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Retailer_userId_key" ON "Retailer"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "FinalCustomer_userId_key" ON "FinalCustomer"("userId");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_invoicingId_fkey" FOREIGN KEY ("invoicingId") REFERENCES "Invoicing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SuperAdmin" ADD CONSTRAINT "SuperAdmin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Retailer" ADD CONSTRAINT "Retailer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Retailer" ADD CONSTRAINT "Retailer_superAdId_fkey" FOREIGN KEY ("superAdId") REFERENCES "SuperAdmin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FinalCustomer" ADD CONSTRAINT "FinalCustomer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FinalCustomer" ADD CONSTRAINT "FinalCustomer_retailerId_fkey" FOREIGN KEY ("retailerId") REFERENCES "Retailer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FinalCustomer" ADD CONSTRAINT "FinalCustomer_superAdId_fkey" FOREIGN KEY ("superAdId") REFERENCES "SuperAdmin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contact" ADD CONSTRAINT "Contact_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SmsCampaign" ADD CONSTRAINT "SmsCampaign_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SmsCampaign" ADD CONSTRAINT "SmsCampaign_operateurId_fkey" FOREIGN KEY ("operateurId") REFERENCES "Operateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SmsCampaign" ADD CONSTRAINT "SmsCampaign_invoicingId_fkey" FOREIGN KEY ("invoicingId") REFERENCES "Invoicing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tarif" ADD CONSTRAINT "Tarif_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tarif" ADD CONSTRAINT "Tarif_operateurId_fkey" FOREIGN KEY ("operateurId") REFERENCES "Operateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Api" ADD CONSTRAINT "Api_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
