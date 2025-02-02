import { Injectable } from '@nestjs/common';
import { PrismaService } from 'nestjs-prisma';
import { CreateAgentDto } from './dto/create-agent.dto';

@Injectable()
export class AgentsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: CreateAgentDto) {
    const { userData, ...agentData } = data;
    return await this.prisma.agent.create({
      data: {
        ...agentData,
        user: {
          create: userData,
        },
      },
    });
  }
}
