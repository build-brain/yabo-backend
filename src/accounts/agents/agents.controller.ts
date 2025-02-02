import {
  Controller,
  Post,
  Body,
  Get,
  Query,
  Param,
  ParseIntPipe,
  Patch,
  Delete,
} from '@nestjs/common';
import { ApiTags, ApiCreatedResponse, ApiOkResponse } from '@nestjs/swagger';
import { CreateUserDto, UpdateUserDto } from '../users/dto';
import { UserEntity, UserWithExpandedAgentEntity } from '../users/entity';
import { AgentQueryParamsDto, CreateAgentDto, UpdateAgentDto } from './dto';
import {
  AgentEntity,
  AgentWIithExpandedUserEntity,
  PaginatedAgentsEntity,
} from './entity';
import { AgentsService } from './agents.service';

@ApiTags('agents')
@Controller('agents')
export class AgentsController {
  constructor(private readonly agentsService: AgentsService) {}

  @ApiCreatedResponse({ type: UserWithExpandedAgentEntity })
  @Post()
  async create(@Body() data: CreateAgentDto) {
    return new UserWithExpandedAgentEntity(
      await this.agentsService.create(data),
    );
  }

  @ApiOkResponse({ type: PaginatedAgentsEntity })
  @Get()
  async findAll(@Query() params: AgentQueryParamsDto) {
    const { data, meta } = await this.agentsService.findAll(params);
    const transdormedData = data.map((agent) => new AgentEntity(agent));
    return { data: transdormedData, meta };
  }

  @ApiOkResponse({ type: AgentWIithExpandedUserEntity })
  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number) {
    return new AgentWIithExpandedUserEntity(
      await this.agentsService.findOne(id),
    );
  }

  @ApiOkResponse({ type: UserWithExpandedAgentEntity })
  @Patch(':id')
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() data: UpdateAgentDto,
  ) {
    return new UserWithExpandedAgentEntity(
      await this.agentsService.update(id, data),
    );
  }

  @ApiOkResponse({ type: AgentWIithExpandedUserEntity })
  @Delete(':id')
  async remove(@Param('id', ParseIntPipe) id: number) {
    return new AgentWIithExpandedUserEntity(
      await this.agentsService.remove(id),
    );
  }
}
