import "./styles/app.scss";

import Rails from "rails-ujs";
import "bootstrap";

import * as ActiveStorage from "activestorage";
import "../utils/direct_uploads";

ActiveStorage.start();

Rails.start();
