-- CreateEnum
CREATE TYPE "ProductShowTo" AS ENUM ('ANY', 'CFO', 'CFM');

-- CreateEnum
CREATE TYPE "ProductUsage" AS ENUM ('PROFESSIONAL', 'HOMECARE');

-- CreateEnum
CREATE TYPE "ProductSteps" AS ENUM ('PREPARE', 'PEELING', 'POSTPEELING', 'MAINTENANCE');

-- CreateTable
CREATE TABLE "Color" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Color_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PackageSupplier" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PackageSupplier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PackageNature" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PackageNature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Package" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "nickname" TEXT,
    "image" TEXT,
    "width" DOUBLE PRECISION NOT NULL,
    "length" DOUBLE PRECISION NOT NULL,
    "height" DOUBLE PRECISION NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,
    "volume" TEXT NOT NULL,
    "colorId" UUID NOT NULL,
    "natureId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Package_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductNature" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProductNature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "nickname" TEXT,
    "image" TEXT,
    "description" TEXT,
    "composition" TEXT,
    "price" DOUBLE PRECISION NOT NULL,
    "volume" TEXT NOT NULL,
    "showTo" "ProductShowTo" NOT NULL,
    "usage" "ProductUsage" NOT NULL,
    "steps" "ProductSteps"[],
    "packageId" UUID NOT NULL,
    "natureId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PackageToPackageSupplier" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Color_name_key" ON "Color"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Color_slug_key" ON "Color"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "PackageSupplier_name_key" ON "PackageSupplier"("name");

-- CreateIndex
CREATE UNIQUE INDEX "PackageSupplier_slug_key" ON "PackageSupplier"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "PackageNature_name_key" ON "PackageNature"("name");

-- CreateIndex
CREATE UNIQUE INDEX "PackageNature_slug_key" ON "PackageNature"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "ProductNature_name_key" ON "ProductNature"("name");

-- CreateIndex
CREATE UNIQUE INDEX "ProductNature_slug_key" ON "ProductNature"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "_PackageToPackageSupplier_AB_unique" ON "_PackageToPackageSupplier"("A", "B");

-- CreateIndex
CREATE INDEX "_PackageToPackageSupplier_B_index" ON "_PackageToPackageSupplier"("B");

-- AddForeignKey
ALTER TABLE "Package" ADD CONSTRAINT "Package_colorId_fkey" FOREIGN KEY ("colorId") REFERENCES "Color"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Package" ADD CONSTRAINT "Package_natureId_fkey" FOREIGN KEY ("natureId") REFERENCES "PackageNature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "Package"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_natureId_fkey" FOREIGN KEY ("natureId") REFERENCES "ProductNature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PackageToPackageSupplier" ADD CONSTRAINT "_PackageToPackageSupplier_A_fkey" FOREIGN KEY ("A") REFERENCES "Package"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PackageToPackageSupplier" ADD CONSTRAINT "_PackageToPackageSupplier_B_fkey" FOREIGN KEY ("B") REFERENCES "PackageSupplier"("id") ON DELETE CASCADE ON UPDATE CASCADE;
