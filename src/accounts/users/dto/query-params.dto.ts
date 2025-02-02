import { ApiProperty } from '@nestjs/swagger';
import { Role } from '@prisma/client';
import { Type } from 'class-transformer';
import { IsEnum, IsOptional, IsDate, IsInt, IsPositive } from 'class-validator';
import { BaseQueryParamsDto, SortOrder } from 'src/common/dto';

export class UserQueryParamsDto extends BaseQueryParamsDto {

  @IsEnum(Role)
  @IsOptional()
  @ApiProperty({
    description: 'Filter by user role (e.g., ADMIN, USER)',
    enum: Role,
    required: false,
  })
  readonly role?: Role;

  @IsDate()
  @Type(() => Date)
  @IsOptional()
  @ApiProperty({
    description: 'Filter by user creation date in ISO format',
    example: '2024-01-01T00:00:00.000Z',
    required: false,
  })
  readonly createdDate?: Date;

  @IsEnum(SortOrder)
  @IsOptional()
  @ApiProperty({
    description: 'Sort by birth date (ASC or DESC)',
    enum: SortOrder,
    required: false,
  })
  readonly byBirthDate?: SortOrder;

  @IsEnum(SortOrder)
  @IsOptional()
  @ApiProperty({
    description: 'Sort by role (ASC or DESC)',
    enum: SortOrder,
    required: false,
  })
  readonly byRole?: SortOrder;

  @IsEnum(SortOrder)
  @IsOptional()
  @ApiProperty({
    description: 'Sort by creation date (ASC or DESC)',
    enum: SortOrder,
    required: false,
  })
  readonly byCreatedDate?: SortOrder;
}
