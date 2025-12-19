package com.campify.backend.mapper;

import com.campify.backend.model.User;
import com.campify.backend.payload.AuthDtos;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-12-17T21:58:54+0100",
    comments = "version: 1.5.5.Final, compiler: Eclipse JDT (IDE) 3.44.0.v20251118-1623, environment: Java 21.0.9 (Eclipse Adoptium)"
)
@Component
public class UserMapperImpl implements UserMapper {

    @Override
    public AuthDtos.UserDto toDto(User user) {
        if ( user == null ) {
            return null;
        }

        AuthDtos.UserDto userDto = new AuthDtos.UserDto();

        userDto.setAvatarUrl( user.getAvatarUrl() );
        userDto.setEmail( user.getEmail() );
        userDto.setFirstName( user.getFirstName() );
        userDto.setId( user.getId() );
        userDto.setLastName( user.getLastName() );
        userDto.setPhoneNumber( user.getPhoneNumber() );
        userDto.setRole( user.getRole() );

        return userDto;
    }

    @Override
    public User toEntity(AuthDtos.UserDto userDto) {
        if ( userDto == null ) {
            return null;
        }

        User.UserBuilder user = User.builder();

        user.avatarUrl( userDto.getAvatarUrl() );
        user.email( userDto.getEmail() );
        user.firstName( userDto.getFirstName() );
        user.id( userDto.getId() );
        user.lastName( userDto.getLastName() );
        user.phoneNumber( userDto.getPhoneNumber() );
        user.role( userDto.getRole() );

        return user.build();
    }
}
