package com.campify.backend.mapper;

import com.campify.backend.model.User;
import com.campify.backend.payload.AuthDtos;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2026-01-24T02:43:53+0100",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 21.0.6 (Oracle Corporation)"
)
@Component
public class UserMapperImpl implements UserMapper {

    @Override
    public AuthDtos.UserDto toDto(User user) {
        if ( user == null ) {
            return null;
        }

        AuthDtos.UserDto userDto = new AuthDtos.UserDto();

        userDto.setId( user.getId() );
        userDto.setEmail( user.getEmail() );
        userDto.setFirstName( user.getFirstName() );
        userDto.setLastName( user.getLastName() );
        userDto.setAvatarUrl( user.getAvatarUrl() );
        userDto.setRole( user.getRole() );
        userDto.setPhoneNumber( user.getPhoneNumber() );
        userDto.setCreatedAt( user.getCreatedAt() );

        return userDto;
    }

    @Override
    public User toEntity(AuthDtos.UserDto userDto) {
        if ( userDto == null ) {
            return null;
        }

        User.UserBuilder user = User.builder();

        user.id( userDto.getId() );
        user.email( userDto.getEmail() );
        user.firstName( userDto.getFirstName() );
        user.lastName( userDto.getLastName() );
        user.phoneNumber( userDto.getPhoneNumber() );
        user.avatarUrl( userDto.getAvatarUrl() );
        user.role( userDto.getRole() );
        user.createdAt( userDto.getCreatedAt() );

        return user.build();
    }
}
