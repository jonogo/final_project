<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- 푸터 -->
 <footer class="footer py-4  ">
        <div class="container-fluid">
          <div class="row align-items-center justify-content-lg-between">
            <div class="col-lg-6 mb-lg-0 mb-4">
              <div class="copyright text-center text-sm text-muted text-lg-start">
                &copy; 2023 신발팜 All rights reserved
              </div>
            </div>
            <div class="col-lg-6">
              <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                <li class="nav-item mr-3">
                  <a href="/board/main" class="nav-link text-muted" target="_blank">
                    <span style="font-family: SaenggeoJincheon !important; font-size: 23px;">
                      신발팜
                    </span>
                    메인으로</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </footer>
<!-- /푸터 -->
</div>
  </main>
  <!--   Core JS Files   -->
  <script src="/manager/assets/js/core/popper.min.js"></script>
  <script src="/manager/assets/js/core/bootstrap.min.js"></script>
  <script src="/manager/assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="/manager/assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="/manager/assets/js/material-dashboard.min.js?v=3.0.4"></script>

</body>
</html>