var HomePage = {
  template: "#home-page",
  data: function() {
    return {
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
      currentBank: {},
      sortAttribute: "title",
      sortAscending: true
    };
  },

  created: function() {
    axios.get("http://localhost:3000/banks").then(function(response) {
      this.banks = response.data; //array or banks data
      //console.log(response.data);
    }.bind(this));
  },

  methods: {
    setSortAttribute: function(attribute) {
      if(attribute !== this.sortAttribute) {
        this.sortAscending = true;
      } else {
        this.sortAscending = !this.sortAscending;
      }
      this.sortAttribute = attribute;
    }
  },

  computed: {
    sortedBanks: function() {
      console.log(this.banks);
      return this.banks.sort(function(bank1, bank2) {
        if(this.sortAscending) {
          return bank1[this.sortAttribute].toString().localeCompare(bank2[this.sortAttribute].toString());
        } else {
          return bank2[this.sortAttribute].toString().localeCompare(bank1[this.sortAttribute].toString());
        }
      }.bind(this));
    }
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
      this.products = response.data;
    }.bind(this));
  }
};

var CategoriesShowPage = {
  template: "#categories-show-page",
  data: function() {
    return {
      category: {},
      sortAttribute: "rating",
      sortAscending: false
    };
  },

  created: function() {
    axios.get("/categories/" + this.$route.params.id).then(function(response) {
      console.log(response.data);
      this.category = response.data;
    }.bind(this));
  },
  methods: {
    setSortAttribute: function(attribute) {
      if(attribute !== this.sortAttribute) {
        this.sortAscending = true;
      } else {
        this.sortAscending = !this.sortAscending;
      }
      this.sortAttribute = attribute;
    }
  },

  computed: {
    sortedProducts: function() {
      return this.category.products.sort(function(product1, product2) {
        if(this.sortAscending) {
          return product1[this.sortAttribute].toString().localeCompare(product2[this.sortAttribute].toString());
        } else {
          return product2[this.sortAttribute].toString().localeCompare(product1[this.sortAttribute].toString());
        }
      }.bind(this));
    }
  }
};

var ProductsShowPage = {
  template: "#products-show-page",
  data: function() {
    return {
      products: [],
      product: {},
      product_also1: {},
      product_also2: {},
      text: "",
      stars: "",
      current_user: {},
      errors: [],
      currentReview: {},
      sortAttribute: "created_at",
      sortAscending: false
    };
  },
  created: function() {
    axios.get("http://localhost:3000/products").then(function(response) {
      //console.log(response.data);
      this.products = response.data;
    }.bind(this));
    axios.get("/products/" + this.$route.params.id).then(function(response) {
      //console.log(response.data);
      this.product = response.data;
      this.reviews = this.product.reviews;
      //console.log(this.reviews);
    }.bind(this));
    // axios.get("/reviews/" + this.$route.params.id).then(function(response) {
    //   //console.log(response.data);
    //   this.stars = response.data.stars;
    //   this.text = response.data.text;
    // }.bind(this));
    axios.get("/users/user").then(function(response) {
      this.current_user = response.data;
      //console.log(this.current_user);
    }.bind(this));
    axios.get("/products/2").then(function(response) {
      //console.log(response.data);
      this.product_also1 = response.data;
    }.bind(this));
    axios.get("/products/3").then(function(response) {
      //console.log(response.data);
      this.product_also2 = response.data;
    }.bind(this));
  },

  methods: {
    submit: function() {
      var params = {
        product_id: this.product.id,
        stars: this.stars,
        text: this.text
      };
      axios
        .post("/reviews", params)
        .then(function(response) {
          router.push("/categories");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    },

    toggle: function() {
      var newReviewDiv = document.getElementById('newReview');
      newReviewDiv.classList.toggle('hidden');
    },

    setSortAttribute: function(attribute) {
      if(attribute !== this.sortAttribute) {
        this.sortAscending = true;
      } else {
        this.sortAscending = !this.sortAscending;
      }
      this.sortAttribute = attribute;
    },

    setCurrentReview: function(id) {
      axios.get("/reviews/" + id).then(function(response) {
      console.log(response);
        this.stars = response.data.stars;
        this.text = response.data.text;
        this.currentReview = response.data;
      }.bind(this));

    },

    submEditRev: function() {
      var params = {
        product_id: this.product.id,
        stars: this.stars,
        text: this.text
      };
        //console.log(this.currentReview.id);
      axios
      .patch("/reviews/" + this.currentReview.id, params)
      .then(function(response) {
        // router.push("/products/" + this.product.id);
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
      axios.get("/products/" + this.$route.params.id).then(function(response) {
        //console.log(response.data);
        this.product = response.data;
      }.bind(this));
    },

    topProducts: function() {
      var categoryArr = this.products.filter(b_product => b_product.category_id === this.product.category_id); 
      categoryArr.sort((a, b) => a.rating - b.rating);
        console.log(categoryArr[0].rating, categoryArr[1].rating)
        if (categoryArr[0].id === this.product.id) {
          return result = [categoryArr[1], categoryArr[2]];
        } else if (categoryArr[1].id === this.product.id) {
          return result = [categoryArr[0], categoryArr[2]];
        } else {
          return result = [categoryArr[0], categoryArr[1]];
        } 
    }

  },
  computed: {
    sortedReviews: function() {
      return this.product.reviews.sort(function(review1, review2) {
        if(this.sortAscending) {
          return review1[this.sortAttribute].toString().localeCompare(review2[this.sortAttribute].toString());
        } else {
          return review2[this.sortAttribute].toString().localeCompare(review1[this.sortAttribute].toString());
        }
      }.bind(this));
    }
  }
};

var BanksShowPage = {
  template: "#banks-show-page",
  data: function() {
    return {
      bank: {},
      current_user: {},
      product_id: "",
      text: "",
      stars: "",
      bank_also1: {},
      bank_also2: {},
      errors: [],
      sortAttribute: "created_at",
      sortAscending: false,
      reviews: []
    };
  },
  created: function() {
    axios.get("/banks/" + this.$route.params.id).then(function(response) {
      console.log(response.data);
      this.bank = response.data;
      this.reviews = this.bank.reviews;
      console.log(this.reviews);
    }.bind(this));
    axios.get("/users/user").then(function(response) {
      this.current_user = response.data;
      console.log(this.current_user);
    }.bind(this));
    axios.get("/banks/2").then(function(response) {
      console.log(response.data);
      this.bank_also1 = response.data;
    }.bind(this));
    axios.get("/banks/3").then(function(response) {
      console.log(response.data);
      this.bank_also2 = response.data;
    }.bind(this));
  },

  methods: {
    submit: function() {
      var params = {
        product_id: this.product_id,
        stars: this.stars,
        text: this.text
      };
      axios
        .post("/reviews", params)
        .then(function(response) {
          router.push("/categories");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }, 

    subEditRev: function() {
      var params = {
        product_id: this.product_id,
        stars: this.stars,
        text: this.text
      };
        //console.log(this.currentReview.id);
      axios
      .patch("/reviews/" + this.currentReview.id, params)
      .then(function(response) {
        // router.push("/products/" + this.product.id);
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
      axios.get("/products/" + this.$route.params.id).then(function(response) {
        //console.log(response.data);
        this.product = response.data;
      }.bind(this));
    },

    toggle: function() {
      var nReviewDiv = document.getElementById('nReview');
      nReviewDiv.classList.toggle('hidden');
    },

    toggleEditRev: function() {
      var editReviewDiv = document.getElementById('editReview');
      editReviewDiv.classList.toggle('hidden');
    },

    setSortAttribute: function(attribute) {
      if(attribute !== this.sortAttribute) {
        this.sortAscending = true;
      } else {
        this.sortAscending = !this.sortAscending;
      }
      this.sortAttribute = attribute;
    },

    setCurrentReview: function(id) {
      axios.get("/reviews/" + id).then(function(response) {
      console.log(response);
        this.product_id = response.data.product_id;
        this.stars = response.data.stars;
        this.text = response.data.text;
        this.currentReview = response.data;
      }.bind(this));
    }    
  },
  computed: {
    sortedReviews: function() {
      return this.reviews.sort(function(review1, review2) {
        if(this.sortAscending) {
          return review1[this.sortAttribute].toString().localeCompare(review2[this.sortAttribute].toString());
        } else {
          return review2[this.sortAttribute].toString().localeCompare(review1[this.sortAttribute].toString());
        }
      }.bind(this));
    }
  }
};

var UsersShowPage = {
  template: "#users-show-page",
  data: function() {
    return {
      current_user: {},
      id: "",
      first_name: "",
      second_name: "",
      last_name: "",
      email: "",
      image_url: "",
      total_reviews: "",
      date_of_birth: ""
    };
  },
  created: function() {
    axios.get("/users/" + this.$route.params.id).then(function(response) {
      this.first_name = response.data.first_name;
      this.second_name = response.data.second_name;
      this.last_name = response.data.last_name;
      this.email = response.data.email;
      this.image_url = response.data.image_url;
      this.date_of_birth = response.data.date_of_birth;
      this.current_user = response.data;
      this.total_reviews = response.data.total_reviews;
      //console.log(response.data);
    }.bind(this));
  },

  methods: {
    deleteUser: function(user) {
      axios.delete("/users/" + user.id).then(function(response) {
          router.push("/");
        })
    }
  }
};

var UsersEditPage = {
  template: "#users-edit-page",
  data: function() {
    return {
      full_name: "",
      first_name: "",
      second_name: "",
      last_name: "",
      email: "",
      image_url: "",
      date_of_birth: "",
      total_reviews: "",
      errors: []
    };
  },
  created: function() {
    axios.get("/users/" + this.$route.params.id).then(
      function(response) {
        this.first_name = response.data.first_name;
        this.second_name = response.data.second_name;
        this.last_name = response.data.last_name;
        this.email = response.data.email;
        this.image_url = response.data.image_url;
        this.date_of_birth = response.data.date_of_birth;
        this.total_reviews = response.data.total_reviews;
        this.full_name = this.first_name + " " +  this.second_name + " " + this.last_name;
      }.bind(this)
    );
  },
  methods: {
    submit: function() {
      var params = {
        first_name: this.first_name,
        second_name: this.second_name,
        last_name: this.last_name,
        email: this.email,
        image_url: this.image_url,
        date_of_birth: this.date_of_birth
      };
      axios
        .patch("/users/" + this.$route.params.id, params)
        .then(function(response) {
          router.push("/users/" + this.id);
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
            router.push("/");
          }.bind(this)
        );
    },

    deleteUser: function(user) {
      axios.delete("/users/" + user.id).then(function(response) {
        router.push("/");
      })
    }

  }
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      first_name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        first_name: this.first_name,
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
    router.push("/#/login");
  }
};

var CategoriesIndexPage = {
  template: "#categories-index-page",
  data: function() {
    return {
      categories: [],
      sortAttribute: "id",
      sortAscending: true
    };
  },
  created: function() {
    axios.get("/categories").then(function(response) {

      this.categories = response.data;
      console.log(response.data);
    }.bind(this));
  },

  methods: {
    setSortAttribute: function(attribute) {
      if(attribute !== this.sortAttribute) {
        this.sortAscending = true;
      } else {
        this.sortAscending = !this.sortAscending;
      }
      this.sortAttribute = attribute;
    }
  },

  computed: {
    sortedCategories: function() {
      return this.categories.sort(function(category1, category2) {
        if(this.sortAscending) {
          return category1[this.sortAttribute].toString().localeCompare(category2[this.sortAttribute].toString());
        } else {
          return category2[this.sortAttribute].toString().localeCompare(category1[this.sortAttribute].toString());
        }
      }.bind(this));
    }
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/banks", component: BanksIndexPage },
    { path: "/products", component: ProductsIndexPage },
    { path: "/categories", component: CategoriesIndexPage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/categories/:id", component: CategoriesShowPage },
    { path: "/products/:id", component: ProductsShowPage },
    { path: "/users/:id", component: UsersShowPage },
    { path: "/users/:id/edit", component: UsersEditPage },
    { path: "/banks/:id", component: BanksShowPage }

  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  data: function() {
    return {
      current_user: {}
    };
  },
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
    axios.get("/users/user").then(function(response) {
      this.current_user = response.data;
      console.log(this.current_user);
    }.bind(this));
  }


});
