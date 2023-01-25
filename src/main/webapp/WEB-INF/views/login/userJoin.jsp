<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/include.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/common/head.jsp" %>
    <title>Title</title>
</head>
<body>
<div class="box" style="margin-top: 200px; text-align: center"> <h1>Stock Chart</h1> </div>
<div class="container col-xl-10 col-xxl-8 px-4 py-5 mt-4">
    <div class="row align-items-center g-lg-5 py-5">
        <div class=" mx-auto col-lg-5" style="width: 1000px;">
            <form class="p-4 p-md-5 border rounded-3 bg-light">
                <h5 class="text-muted" id="usrNmValid">사용자 이름 </h5>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="usrNm" >
                    <label for="usrNm">(한글 2-4자 이내)</label>
                </div>
                <div class="text-success">
                    <hr>
                </div><br>
                <h5 class="text-muted"  id="lgnIdValid">아이디 </h5>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="lgnId"  >
                    <label for="lgnId">(영소문자 또는 숫자 6 ~ 20자 이내) </label>
                </div>
                <div class="text-success">
                    <hr>
                </div><br>
                <h5 class="text-muted"  id="lgnPwdValid">비밀번호</h5>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="lgnPwd" >
                    <label for="lgnPwd">8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="lgnPwdConfirm" >
                    <label for="lgnPwdConfirm">비밀번호 확인</label>
                </div>
                <div class="text-success">
                    <hr>
                </div><br>
                <h5 class="text-muted" id="emlAddrValid">이메일 주소</h5>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="emlAddr">
                    <label for="emlAddr">이메일 형식(abc@Example.com) </label>
                </div>
                <br>
                <a class="w-100 btn btn-lg btn-primary" onclick="javascript:join();">가입하기</a>
            </form>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function() {

        /* Enter키 누를때때 */
       $('#usrNm, #lgnId, #lgnPwd, #lgnPwdConfirm, #emlAddr').on('keypress', function() {
            if (event.keyCode === 13) {
                join();
            }
        });

    });



    function join(){
        var $usrNm = $('#usrNm');  //사용자 이름
        var $lgnId = $('#lgnId');  //아이디
        var $lgnPwd = $('#lgnPwd');  //비밀번호
        var $lgnPwdConfirm = $('#lgnPwdConfirm'); //비밀번호 확인
        var $emlAddr = $('#emlAddr'); //이메일 주소

        var regUsrNm = /^[가-힣]{2,4}$/; //한글 이름 2~4자 이내 정규식
        var regLgnId = /^[a-z]+[a-z0-9]{5,19}$/g;  //아이디 영문자 또는 숫자 6 ~ 20자리 정규식
        var reglgnPwd = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/; // 비밀번호 8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합 정규식
        var regEmlAddr = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; //이메일 체크 정규식


        //사용자 이름 검증
        if(!regUsrNm.test( $usrNm.val().trim() )){
            alert("사용자 이름을 확인하시기 바랍니다. (한글 2-4자 이내)");
            $('#usrNmValid').removeClass("text-muted").addClass("text-danger");
            return false;
        }else{
            $('#usrNmValid').removeClass("text-danger text-muted").addClass("text-success");
        }

        //아이디 검증
        if(!regLgnId.test( $lgnId.val().trim() )){
            alert("아이디를 확인하시기 바랍니다. (영소문자 또는 숫자 6 ~ 20자리 이내)");
            $('#lgnIdValid').removeClass("text-muted").addClass("text-danger");
            return false;
        }else{
            $('#lgnIdValid').removeClass("text-danger text-muted").addClass("text-success");
        }

        //비밀번호 검증
        if(!reglgnPwd.test( $lgnPwd.val().trim() )){
            alert("비밀번호를 확인하시기 바랍니다. (비밀번호 8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합)");
            $('#lgnPwdValid').removeClass("text-muted").addClass("text-danger");
            return false;
        }else{
            $('#lgnPwdValid').removeClass("text-danger text-muted").addClass("text-success");
        }

        //비밀번호 확인 검증
        if(!($lgnPwd.val().trim() == $lgnPwdConfirm.val().trim())){
            alert("비밀번호 확인과 비밀번호가 일치하지 않습니다.");
            $('#lgnPwdValid').removeClass("text-muted").addClass("text-danger");
            return false;
        }else{
            $('#lgnPwdValid').removeClass("text-danger text-muted").addClass("text-success");
        }

        //이메일 주소 검증
        if(!regEmlAddr.test( $emlAddr.val().trim() )){
            alert("이메일을 확인하시기 바랍니다.");
            $('#emlAddrValid').removeClass("text-muted").addClass("text-danger");
            return false;
        }else{
            $('#emlAddrValid').removeClass("text-danger text-muted").addClass("text-success");
        }

        $.post(CONTEXT_PATH + '/join', { // 회원가입
            usrNm: $usrNm.val().trim(),
            lgnId: $lgnId.val().trim(),
            lgnPwd : $lgnPwd.val().trim(),
            emlAddr : $emlAddr.val().trim()
        }, function(result) { // $.ajsx(success: function() {}, fail(alert(msg))
            console.log(result);
            alert(result.message);
            if(!(result.status == "OK")){
                if(result.code = 0){
                    $('#lgnIdValid').removeClass("text-muted").addClass("text-danger");
                }
            }else{
                location.href = CONTEXT_PATH + '/login';
            }

        }, 'json');
    }


</script>

</html>
