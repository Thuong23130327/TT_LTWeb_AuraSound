<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm - AuraSound</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleProduct.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleCart.css">
</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>
<main>
    <section class="container sproduct my-5 pt-5">
        <div class="row">
            <div class="gallery-container col-lg-5 col-md-12 col-12">
                <div class="main-img-container">
                    <img class="main-img img-fluid w-100 pb-1" src="${curVariant.mainImageUrl}" width="100%"
                         id="MainImg">
                </div>

                <div class="thumb-container">
                    <button class="scroll-btn left" onclick="prevImage()">&#10094;</button>

                    <div class="small-img-group" id="thumbScroll">
                        <c:forEach items="${images}" var="eachImg">
                            <img src="${eachImg.imageUrl}"
                                 class="small-img ${eachImg.imageUrl == curVariant.mainImageUrl ? 'active' : ''}"
                                 onclick="changeMainImg(this.src)">
                        </c:forEach>
                    </div>

                    <button class="scroll-btn right" onclick="nextImage()">&#10095;</button>
                </div>
            </div>

            <div class="info col-lg-6 col-md-12 col-12">
                <h6>
                    <a href="/AuraSound">Home</a>
                    <c:forEach var="cate" items="${categories}">
                        / <a href="${applicationScope.AuraSound}/product?cateId=${cate.id}">
                            ${cate.name}
                    </a>
                    </c:forEach>
                </h6>
                <h3>${product.name}</h3>
                <div class="star">
                    <span>${product.avgRating}</span>
                    <i class='bx bxs-star'></i>
                </div>

                <div class="price-block">
                    <span class="new-price" id="new-price"><fmt:formatNumber value="${product.sellPrice}"
                                                                             pattern="#,###"/> đ</span>
                    <span class="old-price" id="old-price"><fmt:formatNumber value="${product.oldPrice}"
                                                                             pattern="#,###"/> đ</span>
                </div>
                <form action="cart" method="post">
                    <div class="product-options">
                        <h4>Màu sắc: </h4>
                        <div class="color-options">
                            <c:forEach var="eachVar" items="${variants}">
                                <div class="color-item ${eachVar.id==curVariant.id?'active':''}"
                                     onclick="selectVariant(this)"
                                     data-id="${eachVar.id}"
                                     data-sellPrice="${eachVar.sellPrice}"
                                     data-marketPrice="${eachVar.marketPrice}"
                                     data-stock="${eachVar.stockQuantity}"
                                     data-img="${eachVar.mainImageUrl}">
                                    <img src="${eachVar.mainImageUrl}" alt="${eachVar.colorName}">
                                    <span>${eachVar.colorName}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="product-quantity">
                        <h4>Số lượng còn:
                            <span id="stock"
                                  data-stock="${curVariant.stockQuantity}">${curVariant.stockQuantity} </span>
                        </h4>
                        <button type="button" class="quantity-btn" onclick="updateQuan(-1)">-</button>
                        <input name="quantity" id="quanProduct" type="number" onchange="checkInput()" value="1">
                        <button type="button" class="quantity-btn" onclick="updateQuan(+1)">+</button>

                        <input type="hidden" name="variants" id="ipListVar" value="${variants}">
                        <input type="hidden" name="nameProduct" id="ipNameP" type="text" value="${product.name}">
                        <input type="hidden" name="variantId" id="selectedVariantId" value="${curVariant.id}">
                    </div>

                    <div class="btn">
                        <button type="submit" class="buy-btn popup" id="cart-btn">Thêm vào giỏ hàng</button>

                        <a href="checkout">
                            <button class="buy-btn">Mua Ngay</button>
                        </a>
                    </div>
                </form>
            </div>
        </div>
        </div>

    </section>

    <section class="container my-5 pt-5">
        <div class="row equal-columns">
            <div class="describe col-lg-6 col-md-12 col-12">
                <div class="specs-container">
                    <h3>Thông số kỹ thuật</h3>

                    <table class="specs-table">
                        <c:forEach items="${specs}" var="eachSpec">
                            <tr>
                                <td class="spec-title">${eachSpec.specName}</td>
                                <td class="spec-value" style="white-space: pre-line;">${eachSpec.specValue}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <div class="col-lg-5 col-md-12 col-12">
                <div class=" describe-container">
                    <h3>Mô tả sản phẩm</h3>
                    <span style="white-space: pre-line;">${product.description}</span>
                </div>
            </div>
        </div>
    </section>

    <section class="boxReview">
        <div class="boxReview-head">
            <h3>Đánh giá</h3>
        </div>
        <div class="boxReview-review">
            <div class="boxReview-overView">
                <div class="score">
                    <span class="average">5.0</span>/5
                    <div class="star">
                        <i class='bx bxs-star'></i>
                        <i class='bx bxs-star'></i>
                        <i class='bx bxs-star'></i>
                        <i class='bx bxs-star'></i>
                        <i class='bx bxs-star'></i>
                    </div>
                    <p>23 lượt đánh giá</p>
                </div>


                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal"
                        onclick="handleReviewClick()">
                    <i class="bi bi-plus-circle"></i> Đánh giá sản phẩm
                </button>


            </div>

            <div class="boxReview-rating">
                <div class="rating-level">
                    <div class="star-count">
                        <div>5</div>
                        <i class='bx bxs-star' style="color: goldenrod;"></i>
                    </div>
                    <progress class="progress" value="100" max="100"></progress>
                    <span>23 đánh giá</span>
                </div>
                <div class="rating-level">
                    <div class="star-count">
                        <div>4</div>
                        <i class='bx bxs-star' style="color: goldenrod;"></i>
                    </div>
                    <progress class="progress" value="0" max="100"></progress>
                    <span>0 đánh giá</span>
                </div>
                <div class="rating-level">
                    <div class="star-count">
                        <div>3</div>
                        <i class='bx bxs-star' style="color: goldenrod;"></i>
                    </div>
                    <progress class="progress" value="0" max="100"></progress>
                    <span>0 đánh giá</span>
                </div>
                <div class="rating-level">
                    <div class="star-count">
                        <div>2</div>
                        <i class='bx bxs-star' style="color: goldenrod;"></i>
                    </div>
                    <progress class="progress" value="0" max="100"></progress>
                    <span>0 đánh giá</span>
                </div>
                <div class="rating-level">
                    <div class="star-count">
                        <div>1</div>
                        <i class='bx bxs-star' style="color: goldenrod;"></i>
                    </div>
                    <progress class="progress" value="0" max="100"></progress>
                    <span>0 đánh giá</span>
                </div>
            </div>

        </div>


    </section>


    <section id="featured" class="my-5 pb-5">
        <div class="container text-center">
            <h3>Sản phẩm nổi bật</h3>
            <hr class="mx-auto">
            <p>Bạn có thể tìm thấy những sản phẩm nổi bật với giá cả hợp lí tại đây.</p>
        </div>
        <div class="row mx-auto container-fluid">
            <div class="product  col-lg-3 col-md-4 col-12">
                <a href="sproduct.html" class="product-card loa page-1">
                    <img src="https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/2162/356825/loa-bluetooth-jbl-partybox-720-1-638976840411732460-750x500.jpg"
                         alt="Loa Bluetooth JBL Partybox 720">
                    <div class="product-card-info">
                        <h4>Loa Bluetooth JBL Partybox 720
                        </h4>
                        <div class="price-block">
                            <span class="new-price">20.900.000đ</span>
                        </div>

                        <div class="product-bottom-row">
                            <div class="rating">
                                <i class="bi bi-star-fill"></i>
                                <span>4.0</span>
                            </div>
                            <div class="favorite">
                                <i class="bi bi-heart"></i> <i class="bi bi-heart-fill"></i>

                                <span>Yêu thích</span>
                            </div>
                        </div>
                    </div>
                </a>
                <a href="checkout.html">
                    <button class="buy-btn">Mua Ngay</button>
                </a>
            </div>

        </div>
    </section>
</main>

<div class="modal fade" id="addVariantModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${AuraSound}/add-Review" method="post"
                  enctype="multipart/form-data">
                <input type="hidden" name="inputPid" value="${product.id}">
                <input type="hidden" name="inputUid" value="${sessionScope.auth.id}">

                <div class="modal-header">
                    <h2 class="modal-title" style="font-size: 16px">Đánh giá ${product.name}</h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label d-block fw-bold">Mức độ hài lòng của bạn:</label>
                        <div class="sentiment-rating">

                            <input type="radio" name="rating" id="rate-1" value="1"/>
                            <label for="rate-1" class="rate-btn btn-very-bad">Cực tệ</label>

                            <input type="radio" name="rating" id="rate-2" value="2"/>
                            <label for="rate-2" class="rate-btn btn-bad">Chưa ổn</label>

                            <input type="radio" name="rating" id="rate-3" value="3"/>
                            <label for="rate-3" class="rate-btn btn-neutral">Trung bình</label>

                            <input type="radio" name="rating" id="rate-4" value="4"/>
                            <label for="rate-4" class="rate-btn btn-good">Tuyệt</label>

                            <input type="radio" name="rating" id="rate-5" value="5" required/>
                            <label for="rate-5" class="rate-btn btn-very-good">Rât hài lòng</label>

                        </div>
                    </div>


                    <div class="mb-3">
                        <label for="comment" class="form-label">Cảm nhận về sản phẩm:</label>
                        <textarea name="comment" id="comment" class="form-control" rows="3"
                                  placeholder="Chia sẻ trải nghiệm của bạn về âm thanh, thiết kế..."></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thêm hình ảnh thực tế (nếu có):</label>
                        <input type="file" name="reviewFiles" class="form-control" accept="image/*" multiple
                        >
                        <div id="review-preview" class="d-flex gap-2 mt-2"></div>
                    </div>

                </div>

                <div class="modal-footer d-flex justify-content-end">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Xác nhận</button>
                </div>
            </form>
        </div>
    </div>


    <%
        String msg = (String) session.getAttribute("msg");
        if (msg != null) {
            if (msg.equals("success")) {
    %>
    <script>
        alert("Cập nhật THÀNH CÔNG!!");
    </script>
    <%
        }
        if (msg.equals("fail")) {
    %>
    <script>
        alert("Cập nhật THẤT BẠI!!");
    </script>
    <%
            }
            session.removeAttribute("msg");
        }
    %>

</div>
<script>
    function handleReviewClick() {
        const isLoggedIn = ${
        sessionScope.auth != null ? 'true' : 'false'
    }
        ;
        if (isLoggedIn) {
            var myModal = new bootstrap.Modal(document.getElementById('addVariantModal'));
            myModal.show();
        } else {
            alert("Vui lòng đăng nhập để tiếp tục đánh giá sản phẩm!");

            window.location.href = '${AuraSound}/login';
        }
    }
</script>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script src="${AuraSound}/assets/js/script.js"></script>
<script src="${AuraSound}/assets/js/scriptProfile.js"></script>
<script src="${AuraSound}/assets/js/scriptStore.js"></script>
<script src="${AuraSound}/assets/js/scriptProduct.js"></script>
</body>
</html>





