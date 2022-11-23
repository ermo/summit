/*
 * SPDX-FileCopyrightText: Copyright © 2020-2022 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * summit.api.v1
 *
 * V1 Summit API
 *
 * Authors: Copyright © 2020-2022 Serpent OS Developers
 * License: Zlib
 */

module summit.api.v1;

public import vibe.d;
public import summit.api.v1.interfaces;

import summit.api.v1.builders;
import summit.api.v1.collections;
import summit.api.v1.pairing;
import summit.api.v1.repositories;
import summit.api.v1.recipes;
import summit.context;

/**
 * Root implementation to configure all supported interfaces
 */
public final class RESTService : SummitAPIv1
{
    @disable this();

    /**
     * Construct the new RESTService root
     *
     * Params:
     *      context = global context
     *      router = nested router
     */
    this(SummitContext context, URLRouter router) @safe
    {
        router.registerRestInterface(this);
        router.registerRestInterface(new BuildersService(context));
        router.registerRestInterface(new CollectionsService(context));
        router.registerRestInterface(new RepositoriesService(context));
        router.registerRestInterface(new RecipesService(context));
        router.registerRestInterface(new PairingService(context));
    }

    /**
     * Returns: Version identifier
     */
    override string versionID() @safe @nogc nothrow const
    {
        return "0.0.1";
    }

private:

    string rootDir;
}
