/*
 *   Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *   WSO2 Inc. licenses this file to you under the Apache License,
 *   Version 2.0 (the "License"); you may not use this file except
 *   in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing,
 *   software distributed under the License is distributed on an
 *   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *   KIND, either express or implied.  See the License for the
 *   specific language governing permissions and limitations
 *   under the License.
 *
 */
package org.wso2.carbon.device.mgt.jaxrs.service.api.admin;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.wso2.carbon.apimgt.annotations.api.Permission;
import org.wso2.carbon.device.mgt.jaxrs.beans.UserCredentialWrapper;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/users")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public interface UserManagementAdminService {

    @POST
    @Path("/{username}/credentials")
    @ApiOperation(
            consumes = MediaType.APPLICATION_JSON,
            produces = MediaType.APPLICATION_JSON,
            httpMethod = "POST",
            value = "Changing the user password.",
            notes = "A user is able to change the password to secure their EMM profile via this REST API.")
    @ApiResponses(value = {
            @ApiResponse(code = 201, message = "User password was successfully changed."),
            @ApiResponse(code = 400, message = "Old password does not match."),
            @ApiResponse(code = 500, message = "Could not change the password of the user. The Character encoding is" +
                    " not supported.")
    })
    @Permission(scope = "user-modify", permissions = {"/permission/admin/login"})
    Response resetPassword(
            @ApiParam(name = "username", value = "Username of the user.",required = true)
            @PathParam("username") String username,
            @ApiParam(name = "credentials", value = "Credential.",required = true)
                    UserCredentialWrapper credentials);

}
