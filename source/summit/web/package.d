/*
 * SPDX-FileCopyrightText: Copyright © 2020-2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * summit.web
 *
 * Root web application (nested)
 *
 * Authors: Copyright © 2020-2023 Serpent OS Developers
 * License: Zlib
 */

module summit.web;

import moss.service.context;
import summit.projects;
import summit.web.accounts;
import summit.web.projects;
import vibe.d;

/**
 * Root entry into our web service
 */
@path("/")
public final class SummitWeb
{
    @disable this();

    /**
     * Construct a new SummitWeb instance
     *
     * Params:
     *      context = global context
     *      projectManager = project management
     *      router = nested routes
     */
    this(ServiceContext context, ProjectManager projectManager, URLRouter router) @safe
    {
        auto root = router.registerWebInterface(this);
        root.registerWebInterface(cast(AccountsWeb) new SummitAccountsWeb(context));
        root.registerWebInterface(new ProjectsWeb(context, projectManager));
    }

    /**
     * Return the "home" page
     */
    void index() @safe
    {
        render!"index.dt";
    }

    /**
     * Render the /builders page
     */
    @path("builders") @method(HTTPMethod.GET)
    void buildersPage() @safe
    {
        render!"builders/index.dt";
    }

    /**
     * Render the /endpoints page
     */
    @path("endpoints") @method(HTTPMethod.GET)
    void endpointsPage() @safe
    {
        render!"endpoints/index.dt";
    }

    /**
     * Render the /tasks page
     */
    @path("tasks") @method(HTTPMethod.GET)
    void tasksPage() @safe
    {
        render!"tasks/index.dt";
    }
}
