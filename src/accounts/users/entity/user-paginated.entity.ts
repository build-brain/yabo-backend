import { ApiProperty } from "@nestjs/swagger";
import { MetaDateEntity } from "src/common/pagination";
import { UserEntity } from "./user.entity";

export class PaginatedUsersEntity {
  @ApiProperty({ type: [UserEntity] })
  data: UserEntity[];

  @ApiProperty({ type: MetaDateEntity })
  meta: MetaDateEntity;
}