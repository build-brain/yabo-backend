import { Injectable } from '@nestjs/common';
import { PrismaService } from 'nestjs-prisma';
import { Prisma, Role } from '@prisma/client';
import { PaginateFunction, paginator } from 'src/common/pagination';
import * as bcrypt from 'bcryptjs';
import { AgentQueryParamsDto, CreateAgentDto, UpdateAgentDto } from './dto';
import { UserWithExpandedAgentEntity } from '../users/entity/user-agent.entity';
import { AgentWIithExpandedUserEntity, PaginatedAgentsEntity } from './entity';

const paginate: PaginateFunction = paginator({ perPage: 10 });

@Injectable()
export class AgentsService {
  constructor(private readonly prisma: PrismaService) {}
  async create(data: CreateAgentDto): Promise<UserWithExpandedAgentEntity> {
    const { userData, ...agentData } = data;
    const hashedPassword = await bcrypt.hash(data.userData.password, 10);

    return await this.prisma.user.create({
      data: {
        ...userData,
        password: hashedPassword,
        role: Role.AGENT,
        agent: {
          create: {
            ...agentData,
          },
        },
      },
      include: { agent: true },
    });
  }

  async findAll(params: AgentQueryParamsDto): Promise<PaginatedAgentsEntity> {
    const {
      search,
      page,
      perPage,
      birthDate,
      createdDate,
      byId,
      byBirthDate,
      byCreatedDate,
    } = params;

    const where: Prisma.AgentWhereInput = {
      ...(search && {
        user: {
          OR: [
            { firstName: { contains: search, mode: 'insensitive' } },
            { lastName: { contains: search, mode: 'insensitive' } },
            { middleName: { contains: search, mode: 'insensitive' } },
          ],
        },
      }),
      ...(birthDate && { birthDate: birthDate }),
      ...(createdDate && {
        user: {
          createdAt: {
            gte: new Date(createdDate.setHours(0, 0, 0, 0)),
            lt: new Date(createdDate.setHours(23, 59, 59, 999)),
          },
        },
      }),
    };

    const orderBy: Prisma.AgentOrderByWithRelationInput = {
      ...(byId && { id: byId }),
      ...(byBirthDate && { birthDate: byBirthDate }),
      ...(byCreatedDate && { user: { createdAt: byCreatedDate } }),
    };

    const include: any = {
      user: true,
    };

    return paginate(
      this.prisma.agent,
      { where, orderBy, include },
      { page, perPage },
    );
  }

  async findOne(id: number): Promise<AgentWIithExpandedUserEntity> {
    return await this.prisma.agent.findUniqueOrThrow({
      where: { id: id },
      include: {
        user: true,
      },
    });
  }

  async update(
    id: number,
    data: UpdateAgentDto,
  ): Promise<UserWithExpandedAgentEntity> {
    const { userData, ...agentData } = data;

    return await this.prisma.user.update({
      where: { id },
      data: {
        ...userData,
        agent: {
          update: {
            data: agentData,
          },
        },
      },
      include: {
        agent: true,
      },
    });
  }

  async remove(id: number): Promise<AgentWIithExpandedUserEntity> {
    return await this.prisma.agent.delete({
      where: { id },
      include: {
        user: true,
      },
    });
  }
}
