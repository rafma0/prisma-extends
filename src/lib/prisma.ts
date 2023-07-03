import { PrismaClient } from '@prisma/client'

type ProductNeeds = {
  nickname?: string
  volume: string
  nature: {
    name: string
  }
  package: {
    color: {
      name: string
    }
  }
}

const prisma = new PrismaClient({
  errorFormat: 'minimal'
}).$extends({
  result: {
    product: {
      name: {
        // needs: {
        //   nickname: true, volume: true, nature: true, package: true
        // },
        compute (product: ProductNeeds) {
          if (!product.nature) {
            return undefined
          }
          let { name } = product.nature
          if (product.nickname) {
            name += ` ${product.nickname}`
          }
          name += ` (${product.volume}) - ${product.package.color.name}`
          return name
        }
      }
    }
  }
})

export default prisma
