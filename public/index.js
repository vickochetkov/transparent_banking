/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Home page"
    };
  },
  created: function() {},
  methods: {},
  computed: {}
};

var BanksIndexPage = {
  template: "#banks-index-page",
  data: function() {
    return {
      banks: [],
      currentBank: {}
    };
  },
  created: function() {
    axios.get("http://localhost:3000/banks").then(function(response) {

      this.banks = response.data; //array or banks data
      //console.log(response.data);

    }.bind(this));
  }  
};

var ProductsIndexPage = {
  template: "#products-index-page",
  data: function() {
    return {
      products: []
    };
  },
  created: function() {
    axios.get("http://localhost:3000/products").then(function(response) {

      this.banks = response.data;
    }.bind(this));
  }  
};

var CategoriesShowPage = {
  template: "#categories-show-page",
  data: function() {
    return {
      category: {},
      products: [], 
      currentProducts: []      
    };
  },
  created: function() {
    axios.get("/categories/" + this.$route.params.id).then(function(response) {
      console.log(response.data);
      this.category = response.data;      
    }.bind(this));
    axios.get("/products").then(function(response) {
      console.log(response.data);
      this.products = response.data;      
      this.currentProducts = this.products.filter(product => product.category_id === this.category.id);           
    }.bind(this));    
  },      
};

var ProductsShowPage = {
  template: "#products-show-page",
  data: function() {
    return {
      product: {},
      product_also1: {},
      product_also2: {}
      //products: [], 
      //currentProducts: []      
    };
  },
  created: function() {
    axios.get("/products/" + this.$route.params.id).then(function(response) {
      //console.log(response.data);
      this.product = response.data;      
    }.bind(this));
    axios.get("/products/2").then(function(response) {
      console.log(response.data);
      this.product_also1 = response.data;      
    }.bind(this));
    axios.get("/products/3").then(function(response) {
      console.log(response.data);
      this.product_also2 = response.data;      
    }.bind(this));
        
  },      
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var CategoriesIndexPage = {
  template: "#categories-index-page",
  data: function() {
    return {
      categories: []
    };
  },
  created: function() {
    axios.get("/categories").then(function(response) {

      this.categories = response.data;
      console.log(response.data);

    }.bind(this));
  }  
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/banks", component: BanksIndexPage },
    { path: "/products", component: ProductsIndexPage },
    { path: "/categories", component: CategoriesIndexPage },
    // { path: "/signup", component: SignupPage },
    // { path: "/login", component: LoginPage },
    // { path: "/logout", component: LogoutPage },
    // { path: "/products/new", component: ProductsNewPage },
    { path: "/categories/:id", component: CategoriesShowPage },
    { path: "/products/:id", component: ProductsShowPage }
    // { path: "/products/:id/edit", component: ProductsUpdatePage },
    // { path: "/images/new", component: ImagesNewPage }

  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
