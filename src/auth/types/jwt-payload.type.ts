import { Role } from '@prisma/client';

export type JwtPayload = {
  sub: number;
  login: string;
  role: Role;
};
