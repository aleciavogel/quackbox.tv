import React from "react";

import Header from "./Header";
import Main from "./Main";

const Layout = ({ children }) => (
  <>
    <Header />
    <Main>{children}</Main>
  </>
);

export default Layout;
