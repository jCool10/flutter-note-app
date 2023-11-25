import _ from 'lodash'

interface getInfoDataInterface {
  field: string[]
  object: any
}

const getInfoData = ({ field, object }: getInfoDataInterface) => _.pick(object, field)

export { getInfoData }
