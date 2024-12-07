import { Body, Controller, Delete, Get, HttpException, Param, Patch, Post } from "@nestjs/common";
import { UserService } from "./user.service";

@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get()
  async getAll(){
    try {
      return await this.userService.getAll()
    } catch (error) {
      throw new HttpException(error.message, error.getStatus ? error.getStatus() : 500);
    }
  }

  @Get(':id')
  async getOne(@Param('id') id: string){
    try {
      return await this.userService.getOne(+id)
    } catch (error) {
      throw new HttpException(error.message, error.getStatus ? error.getStatus() : 500);
    }
  }

  @Post()
  async createOne(@Body() body: { name: string; email: string; password: string }){
    try {
      await this.userService.createOne(body.name, body.email, body.password)
      return {message: "User has been created"}
    } catch (error) {
      throw new HttpException(error.message, error.getStatus ? error.getStatus() : 500);
    }
  }

  @Patch(':id')
  async updateOne(@Param('id') id: string, @Body() body: Partial<{ name: string; email: string; password: string, profilePicture: string, status: string }>){
    try {
      await this.userService.updateOne(+id, body)
      return {message: "User has been updated"}
    } catch (error) {
      throw new HttpException(error.message, error.getStatus ? error.getStatus() : 500);
    }
  }

  @Delete(':id')
  async deleteOne(@Param('id') id: string){
    try {
      await this.userService.deleteOne(+id)
      return {message: "User has been deleted"}
    } catch (error) {
      throw new HttpException(error.message, error.getStatus ? error.getStatus() : 500);
    }
  }
}
