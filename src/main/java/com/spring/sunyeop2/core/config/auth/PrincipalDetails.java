package com.spring.sunyeop2.core.config.auth;


/*
*  로그인이 완료가 되면 Security ContextHolder 라는 키값에 Session을 만들어준다.
*  Session에 들어갈 객체는 Authentication 객체여야한다.
*  Authentication 안에는 우리가 DB에 있는 User 정보가 있어야 되는데
*  이것은 UserDetails 객체 타입으로 만들어야한다.
*
* */


import com.spring.sunyeop2.login.info.User;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.security.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

public class PrincipalDetails implements UserDetails {

    private User user;

    public PrincipalDetails (User user){
        this.user = user;
    }

    // 해당 유저의 권한을 return하는 메소드
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collect = new ArrayList<>();
        collect.add(new GrantedAuthority() {
            @Override
            public String getAuthority() {
                return user.getRoleCd();
            }
        });
        return collect;
    }

    public long getUsrId(){ return user.getUsrId(); }

    public String getLgnId() {
        return user.getLgnId();
    }

    @Override
    public String getPassword() {
        return user.getLgnPwd();
    }

    public String getLgnPwd() {
        return user.getLgnPwd();
    }

    @Override
    public String getUsername() {
        return user.getUsrNm();
    }

    public String getUsrAs(){ return user.getUsrAs(); }

    public String getEmlAddr(){ return user.getEmlAddr(); }

    public Date getJoinDt(){ return user.getJoinDt(); }

    public String getFilePath(){return user.getFilePath();}

    public String getFileNm(){return user.getFileNm();}

    //계정이 만료되지 않았는지
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    //계정이 잠겨있지 않은지
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    //계정의 패스워드가 만료되지 않았는지
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    //계정이 사용가능 한지
    @Override
    public boolean isEnabled() {
        return true;
    }
}
