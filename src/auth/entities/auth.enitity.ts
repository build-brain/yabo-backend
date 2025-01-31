import { ApiProperty } from '@nestjs/swagger';
import { Role } from '@prisma/client';

export class AuthEntity {
  constructor({ ...data }) {
    Object.assign(this, data);
  }
  @ApiProperty({ readOnly: true })
  accessToken: string;

  @ApiProperty({ readOnly: true })
  refreshToken: string;

  @ApiProperty({ readOnly: true })
  userId?: number;

  @ApiProperty({ readOnly: true })
  login?: string;

  @ApiProperty({ readOnly: true })
  userRole?: Role;
}
