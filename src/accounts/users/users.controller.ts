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
import { CreateUserDto, UserQueryParamsDto, UpdateUserDto } from './dto';
import { UserEntity, PaginatedUsersEntity } from './entity';
import { UsersService } from './users.service';

@ApiTags('users')
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @ApiCreatedResponse({ type: UserEntity })
  @Post()
  async create(@Body() data: CreateUserDto) {
    return new UserEntity(await this.usersService.create(data));
  }

  @ApiOkResponse({ type: PaginatedUsersEntity })
  @Get()
  async findAll(@Query() params: UserQueryParamsDto) {
    const { data, meta } = await this.usersService.findAll(params);
    const transdormedData = data.map((user) => new UserEntity(user));
    return { data: transdormedData, meta };
  }

  @ApiOkResponse({ type: UserEntity })
  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number) {
    return new UserEntity(await this.usersService.findOne(id));
  }

  @ApiOkResponse({ type: UserEntity })
  @Patch(':id')
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() data: UpdateUserDto,
  ) {
    return new UserEntity(await this.usersService.update(id, data));
  }

  @ApiOkResponse({ type: UserEntity })
  @Delete(':id')
  async remove(@Param('id', ParseIntPipe) id: number) {
    return new UserEntity(await this.usersService.remove(id));
  }
}
