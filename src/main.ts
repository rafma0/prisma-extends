import prisma from './lib/prisma'

async function main () {
  const product = await prisma.product.findFirstOrThrow({
    include: {
      nature: true,
      package: { include: { color: true } }
    }
  })
  console.log(product.name)
}

main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
