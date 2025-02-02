import { Injectable, BadRequestException } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'nestjs-prisma';
import * as bcrypt from 'bcryptjs';
import { PaginateFunction, paginator } from 'src/common/pagination';
import { CreateUserDto, UserQueryParamsDto, UpdateUserDto } from './dto';

const paginate: PaginateFunction = paginator({ perPage: 10 });

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}
  async create(data: CreateUserDto) {
    try {
      const hashedPassword = await bcrypt.hash(data.password, 10);

      if (data.role !== 'ADMIN') {
        throw new BadRequestException(
          'You cannot create a user with this role',
        );
      }

      return await this.prisma.user.create({
        data: {
          ...data,
          password: hashedPassword,
        },
      });
    } catch (error) {
      if (error.code === 'P2002') {
        throw new BadRequestException('A user with this data already exists');
      }
      throw error;
    }
  }

  async findAll(params: UserQueryParamsDto) {
    const {
      search,
      page,
      perPage,
      role,
      createdDate,
      byId,
      byBirthDate,
      byRole,
      byCreatedDate,
    } = params;

    const where: Prisma.UserWhereInput = {
      ...(search && {
        OR: [
          { firstName: { contains: search, mode: 'insensitive' } },
          { lastName: { contains: search, mode: 'insensitive' } },
          { middleName: { contains: search, mode: 'insensitive' } },
        ],
      }),
      ...(role && { role: role }),
      ...(createdDate && {
        createdAt: {
          gte: new Date(createdDate.setHours(0, 0, 0, 0)),
          lt: new Date(createdDate.setHours(23, 59, 59, 999)),
        },
      }),
    };

    const orderBy: Prisma.UserOrderByWithRelationInput = {
      ...(byId && { id: byId }),
      ...(byRole && { role: byRole }),
      ...(byBirthDate && { birthDate: byBirthDate }),
      ...(byCreatedDate && { createdAt: byCreatedDate }),
    };

    const include: any = {};

    return paginate(
      this.prisma.user,
      { where, orderBy, include },
      { page, perPage },
    );
  }

  async findOne(id: number) {
    return await this.prisma.user.findUniqueOrThrow({
      where: { id },
      include: {},
    });
  }

  async update(id: number, data: UpdateUserDto) {
    await this.prisma.user.findUniqueOrThrow({ where: { id } });
    return await this.prisma.user.update({
      where: { id },
      data,
      include: {},
    });
  }

  async remove(id: number) {
    await this.prisma.user.findUniqueOrThrow({ where: { id } });
    return await this.prisma.user.delete({ where: { id } });
  }
}
