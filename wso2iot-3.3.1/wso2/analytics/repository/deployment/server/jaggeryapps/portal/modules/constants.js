/*
 * Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */


var CONTENT_TYPE_IDENTIFIER = "Content-Type";
var APPLICATION_JSON = "application/json";
var APPLICATION_X_WWW_FOR_URLENCODED = "application/x-www-form-urlencoded";
var APPLICATION_ZIP = "application/zip";

//directory paths
var EXTENSIONS_THEMES_PATH = "/extensions/themes/";
var STORE_PATH = "/store/";
var FS_THEME_PATH = "/fs/theme/";
var EXTENSIONS_LOCALES_PATH = "/extensions/locales/";
var JS_PATH = "js/";
var CSS_PATH = "/css";
var THEME_PATH = "theme/";

var ENCODED_CLIENT_KEYS_IDENTIFIER = "encodedClientKey";
var AUTHORIZATION_HEADER = "Authorization";
var SCOPE_PRODUCTION = "PRODUCTION"
var BEARER_PREFIX = "Bearer ";
var BASIC_PREFIX = "Basic ";
var ACCEPT_IDENTIFIER = "Accept";
var AUTHENTICATION_TYPE_SSO = "sso";
var AUTHENTICATION_TYPE_BASIC = "basic";
var AUTHORIZATION_TYPE_OAUTH = "oauth";
var LOGIN_MESSAGE = "true";
var GRANT_TYPE_PASSWORD = "password";
var GRANT_TYPE_SAML = "saml";
var DEFAULT_THEME = "Default Theme";

var HTTP_GET = "GET";
var HTTP_POST = "POST";
var HTTP_PUT = "PUT";
var HTTP_DELETE = "DELETE";

var HTTP_CONFLICT = 409;
var HTTP_BAD_REQUEST = 400;
var HTTP_CREATED = 201;
var HTTP_UNAUTHORIZED = 401;
var HTTP_USER_NOT_AUTHENTICATED = 403;
var HTTP_INTERNAL_ERROR = 500;
var HTTP_ACCEPTED = 200;

// All the permission related constants
var PORTAL = '/permission/admin/manage/portal';
var LOGIN = '/permission/admin/manage/portal/login';
var DASHBOARD = '/permission/admin/manage/portal/dashboard';
var CREATE = '/permission/admin/manage/portal/dashboard/create';
var SETTINGS = '/permission/admin/manage/portal/dashboard/settings';

var GADGET = '/permission/admin/manage/portal/gadget';
var GADGET_UPLOAD = '/permission/admin/manage/portal/gadget/upload';
var GADGET_DELETE = '/permission/admin/manage/portal/gadget/delete';
var GADGET_GENERATE = '/permission/admin/manage/portal/gadget/generate';

var LAYOUT = '/permission/admin/manage/portal/layout';
var LAYOUT_UPLOAD = '/permission/admin/manage/portal/layout/upload';
var LAYOUT_DELETE = '/permission/admin/manage/portal/layout/delete';

//Internal Role creation constants
var INTERNAL_ROLE = "Internal";
var INTERNAL_ROLE_VIEWER = "viewer";
var INTERNAL_ROLE_EDITOR = "editor";
var INTERNAL_ROLE_OWNER = "owner";
var INTERNAL_ROLE_FORWARDSLASH = "/";
var INTERNAL_ROLE_SEPERATOR = "-";

var FILE_STORE = 'fs';
var ES_STORE = 'es';
var GADGET_TYPE = 'gadget';
var LAYOUT_TYPE = 'layout';

var ES_STORE_DELIMITER = '_';

var DASHBOARD_REGISTRY_PATH = '/_system/config/ues/dashboards';

var ACCESS_TOKEN_PAIR_IDENTIFIER_FOR_PORTAL = "accessTokenPairForPotal";
var ACCESS_TOKEN_PAIR_IDENTIFIER_FOR_PORTAL = "tokenPairForPortal";
var ENCODED_TENANT_BASED_CLIENT_APP_CREDENTIALS_PORTAL_APP = "encodedTenantBasedClientAppCredentialsPortal";
var CONTENT_TYPE_IDENTIFIER = "Content-Type";
var CACHED_CREDENTIALS_PORTAL_APP = "tenantBasedCredentials";
var ALLOWED_SCOPES = "scopeList";