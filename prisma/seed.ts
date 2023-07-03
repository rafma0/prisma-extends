import { PrismaClient, ProductShowTo, ProductUsage } from '@prisma/client'
import slugify from 'slugify'

const prisma = new PrismaClient()

function mapToNameSlug (names: string[]) {
  return names.map((name) => ({
    name,
    slug: slugify(name, { lower: true })
  }))
}

async function main () {
  await prisma.product.deleteMany()
  await prisma.productNature.deleteMany()
  await prisma.package.deleteMany()
  await prisma.packageSupplier.deleteMany()
  await prisma.packageNature.deleteMany()
  await prisma.color.deleteMany()

  await prisma.color.createMany({
    data: mapToNameSlug([
      'Red', 'Green', 'Silver', 'Golden'
    ])
  })

  await prisma.packageSupplier.createMany({
    data: mapToNameSlug([
      'Supplier 1', 'Supplier 2'
    ])
  })

  await prisma.packageNature.createMany({
    data: mapToNameSlug([
      'Pot'
    ])
  })

  const { id: packageId } = await prisma.package.create({
    data: {
      nature: { connect: { slug: 'pot' } },
      nickname: 'Dropper',
      length: 10,
      height: 10,
      width: 10,
      weight: 10,
      volume: '100ml',
      color: { connect: { slug: 'golden' } }
    }
  })

  await prisma.productNature.createMany({
    data: mapToNameSlug([
      'Shampoo', 'Soap', 'Cream', 'Gel', 'Serum', 'Ointment'
    ])
  })

  await prisma.product.create({
    data: {
      nickname: 'Nickname',
      description: 'lorem ipsum',
      price: 49.9,
      volume: '50ml',
      showTo: ProductShowTo.ANY,
      usage: ProductUsage.PROFESSIONAL,
      nature: { connect: { slug: 'soap' } },
      steps: ['PREPARE', 'MAINTENANCE'],
      package: { connect: { id: packageId } }
    }
  })
}

main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
