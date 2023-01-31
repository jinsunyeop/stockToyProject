<body class="bg-light">

<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark" style="position: unset;" aria-label="Main navigation" >
  <div class="container-fluid">
    <a class="navbar-brand" href="#" style="display: block; margin-left: 50px;">My STOCK</a>
    <button class="navbar-toggler p-0 border-0" type="button" id="navbarSideCollapse" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="navbar-collapse offcanvas-collapse" style="margin-left: 100px;" id="navbarsExampleDefault">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0" >
        <li class="nav-item">
          <a class="nav-link" id="headerDashBoard" aria-current="page" href="#">Dashboard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="headerMyPage" href="<c:url value="/main/mypage/myStockList" />">MyPage</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="headerStocks" href="<c:url value="/main/stocks/allStock" />">Stocks</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="headerBoard" href="<c:url value="/userBoard/list" />">UserBoard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" id="headerLogout" href="<c:url value="/logout"/>">LogOut</a>
        </li>
      </ul>

    </div>
  </div>
</nav>